Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A1D606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f+u7fLcR;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=YJfm6hW0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C2FE80DD6;
	Mon, 16 Nov 2026 22:40:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GmA_N-i0iuu3; Mon, 16 Nov 2026 22:40:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E188A80E17
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794868814;
	b=PMOBtMVEHG4TyKOeCSuILYz4TvYoeejBpMvMuG8Gz4YKdNgLwJLO+WKPqfmht2bYsxH4
	 7z8NtFqybCNojEoA4V2mHSFqVIREN6JvWUb/Nkxevn/lEVfrhC4HJFuQc8WL/1anlNGca
	 sXEQGMcJPpxpGEK3nQGOT+xX72X2uDEtrZkzcsKcaBkuriYVboZ87xI3ZNGRAsTwaFPqv
	 dp0oJDFhv6068EpQnvCGXNkJrzatoAOx4GkemOntbdF05ksA8KHE71LnumI7EnlA3i3/m
	 wz7cRMc/Yq2axZmPqE+nA6xefA3Bi1ugsZqxVmhHJirSA3It5YhsmA8UdAaaAegNodQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794868814;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XVrTXvLh+bQ5H7BDRfrevt9ymMa8AE1FWxSqknHxB5g=;
	b=gwtMLYKQuashgECRDwZDGcZpzfTVRMTVPES10tcSm8ZeYHxB1YN47yU+wC8Ozn5B6afy
	 4qCE9g7wki/0igMYpnTAg+TwHjEtmqSFpV26l/rwo5I7kbzZ1BC27sp9eTpBkWXZvdA3F
	 4+yH5P1kE24FS23wXmPQwQsEY8QZW3fk0/khv8i45/sFeKY8SJPKLyLq7Pp8zyTG5HJsG
	 kLDuk3GDYD6D/fpLdhW02MUxRAj73uaaKGX+SLeRnViimO2kvyuYeM1TW8rn2CR78+HkX
	 9hahFP63QnJAGS3hf6ER/DHuDFHyRCtPUsPrdjF9txc7+FuqufezpM/7Pm9qY8wYn/Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=YJfm6hW0;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794868814;
	bh=XVrTXvLh+bQ5H7BDRfrevt9ymMa8AE1FWxSqknHxB5g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f+u7fLcRFp6dqOAsKZyL3dPIDsil0VTl6Xd3sEaiH9oAFJSpuRThOlFdiJQ4ATlRH
	 pqD1+wXza9jySE+V+tqxDcgd+ZGnytYmZ7eiWUHUmPNgYpqfKTzcZqVap/axJ0Zmmf
	 +nlnCsiAHZrMQz9atvIELcV+LLblG0X9RzHvu1qCpKu5vdruASZWpabHNNFKY1K3G8
	 NgcpdOsaIf1M8k0nJxwaLtpSYxtlHYhi0mdw9FmwKL272EhNCypBZ6dExvErmKqIDH
	 bQfwiWqFfKPsxbgUKNfGamT5q2WPbZrl8RR5dKBSMXPC/Ykc2cRiVJW4tTvie2u3K4
	 L7p93KYlyDwxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E188A80E17;
	Mon, 16 Nov 2026 22:40:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FFD5A0E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:40:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 40D3E80E17
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:40:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Kt6SEOzV1PX for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 22:40:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 79E4180DD6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2b; helo=mail-oa1-x2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=YJfm6hW0
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 79E4180DD6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:40:10 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-4ad4072943dso1148231fac.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794868809; x=1795473609;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XVrTXvLh+bQ5H7BDRfrevt9ymMa8AE1FWxSqknHxB5g=;
 b=YJfm6hW05XR7z1jBAdTaq3IKu0jIRehhDAWzTqbpaMwLEf+CSCYRhYZX4L8ajzdjKN
 8hqwxde3Czl5ZbB30rDd77RVSt68xXUYIumaQQ33R7DS5LInY9pC/5dfxLaLh1MRRCTU
 EX9LaU1CbxwbMfvfkn1pkKy8TRZDikOrVBqAXZDVkc5rbdsT6xF+H7z9Ddjp/M41Qgwj
 rHSgmBQf9mmlk/UUIrc173thZe/9kZnoCnsA831vB+HchlveH2ekNmXQFiyUhuw3U/ve
 1A41SRqjsulKs6Yp+zKpWNF9nRN4lKKb40FCTTyfNSYfWX4x8DCmsHJTPL22eq3p0q0o
 d7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794868809; x=1795473609;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XVrTXvLh+bQ5H7BDRfrevt9ymMa8AE1FWxSqknHxB5g=;
 b=KbMXxWf831+Ebw1slF0Wxd5VmuK0A2rzjInK4iujrfaZVViDvf1jVsxhqIXrD1kE8T
 DsSNzEdj7xoW/a6ZYbZJtCBUjEzzdc8N/NAkzmRPwcIw9+ubzv1sxyEwE3P6LsJ90NOt
 0ZNqa9Qhypu2EVYhzZDI3K4yAdel2PQOOXdHi0RYq+aFxY58dVgm/t8dZx7OBiTXJ3z1
 obqfuti2Uvha//tte1fZ0VBhPgz67Mngl3Imq+Jdu6uFFwPYzy+GfbJLfp9J+nwqNyXp
 32/wNV/x5eyMqzXcoH4jfMGYrt9ULFw6+hj6sGsfyVoDfcp6tDkvsaztxUPIOZoZAGPZ
 wRrw==
X-Forwarded-Encrypted: i=1;
 AL+hErFuH/nIsgMvWCzuHlHF/TGUpzvECkr+XGz9rJTswRh/ivOO5jT9fsQRBsN2zM+BIHaEjX2esu0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+MFovTbld6wdiLjlSq/OSP7UzD1wvOOLK3Nqm8v2YmTnzidXHL
 /E0DgeGEecFgVMHOPTo31OsYFUQTfe4Kt/qOGMRE6xfqKsCysZEms9gO75qkrWnrO9k=
X-Gm-Gg: AYBFou0oQtu/TLmIb2GBOGlow6dEO/po/arvXWthNEHMbCpjM8gwtE+U7LeH+Gff6Wu
 UuzUoL54aEi838lrexU3MJ1lH7sPOloofzlkoRFMsOA9Taqdr0Qq0vyaJ27C9O5dtlYsIKRHCb7
 Vb59R/YQmIKugsUNiA4h3r7bPoKBzHazETojqai23Nk4VFmCNKAjU9RkmDPECKHEG419mvWS5jM
 mMvBlEBClZdnc7A1Odt3R8SwUwEvnPqvoERfbqK/btIAa5BazUmjAbp2KCZzUXq0wYTxcak7uI5
 nk1efIRaYEhc2HaFN4M+T4xM0lW2FxhAsCsrEYVUBpshYjJLCIWFm45F7SfHMUavfYgf+Pgdcef
 Yl2YPT6aEWQ69SKGg8o6nrpYNqnGYVpDeh8n4xXxm3/8d7IZfJnW1ZUubMvXN37ilagobq/BJ/s
 DJcAqieC/Ps+QGa1BWqc47ufOu73E7Ga31t1Fbh859U2Tg9zn00keyFc5bWpXW9kZFI/cmBIsd2
 w5bob11WJU0JbFbjwIhYBfPeb1m2frs8u6oZ40/zbMipCAhRhud6i4K5ieIpCNsKi9lfSdBCorK
 MXWX2e+01UKmb9D+g26Rb2yqGm7Qx6qj5Q+a/2GX2kKX1rij5RgvSFrY8g6vbCC3qsYTmgbMfpV
 9Jxr2WXjRYE9+WrAGRrDvz0HL
X-Received: by 2002:a05:6808:16a7:b0:4b3:98f4:f057 with SMTP id
 5614622812f47-56e605a4a03mr9977429b6e.3.1794868809023; 
 Mon, 16 Nov 2026 14:40:09 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:7056:3b5b:7d85:4921?
 ([2600:8803:e7e4:500:7056:3b5b:7d85:4921])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70c56e44sm9728871b6e.14.2026.11.16.14.40.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 14:40:07 -0800 (PST)
Message-ID: <9f91272a-2f34-4192-b0ae-41320ec552c2@baylibre.com>
Date: Mon, 16 Nov 2026 16:40:05 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] ufs: mediatek: skip SiP calls when running at EL3
To: Carlo Caione <ccaione@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com>
 <20261106-mtk-genio-720-spl-ufs-v1-2-90c578b6c43b@baylibre.com>
 <179442384949.26078.15240674797898354872.b4-review@b4>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <179442384949.26078.15240674797898354872.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26 1:04 PM, Carlo Caione wrote:
>> Do not issue the UFS SiP SMCs when U-Boot itself runs at EL3. There is
>> no secure monitor to handle them then, e.g. in SPL before BL31 has been
>> loaded, and an SMC would trap into U-Boot's own exception vectors.
>>
>> The SiP calls only notify the secure world about the reference clock
>> and drive the device reset pin. The firmware stage that ran before SPL
>> has already brought up the UFS device, so the host can still be
>> initialized without them.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>
>> diff --git a/drivers/ufs/ufs-mediatek-sip.h b/drivers/ufs/ufs-mediatek-sip.h
>> index 6a61f7bac69..cb27da1458c 100644
>> --- a/drivers/ufs/ufs-mediatek-sip.h
>> +++ b/drivers/ufs/ufs-mediatek-sip.h
>> @@ -9,6 +9,7 @@
>>  #ifndef _UFS_MEDIATEK_SIP_H
>>  #define _UFS_MEDIATEK_SIP_H
>>  
>> +#include <asm/system.h>
>>  #include <linux/arm-smccc.h>
>>  
>>  /*
>> @@ -37,6 +38,10 @@ struct ufs_mtk_smc_arg {
>>  
>>  static inline void _ufs_mtk_smc(struct ufs_mtk_smc_arg s)
>>  {
>> +	/* No secure monitor to call yet, e.g. in SPL before BL31. */
>> +	if (current_el() == 3)
>> +		return;
> 
> Can we return an error from here? Otherwise functions like
> ufs_mtk_device_reset() are going to assume that the function is
> successful.
> 

I don't think we should consider this an error. We return early because
there is nothing to do, not because we can't do something that is required.
