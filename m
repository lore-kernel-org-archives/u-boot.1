Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44356CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 11:10:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B4BA807DC;
	Wed, 14 Oct 2026 11:10:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BK6iQbFOxrNq; Wed, 14 Oct 2026 11:10:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 32A33807A6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791976248;
	b=ZHCQfpJYskBI1w8EGpS5x2MN6Yv5SEcbN61BXQFQD4WX1lOl4opmgMAyeQrpIfOdKmzX
	 ibe6a6RieaezVbPrkcasOSZQqdxfpFzY3Aj3HOWEe2HjfrkiO2zgWiq1k3x7wEpxDGezQ
	 kPdRoImZcrJ2b0je7c7mAklZbmQ2loChtEG7Sv26+KIjSNaSwuIri3vmk2vUsbqftoJ4Q
	 auCdN0uzhYPc1H7GsRFGlf1cPqSXU4FY234CfBYY/Z2NGvIfBjt2RVvtxpvyRpuyZws+b
	 9fEjhlUI7jKRDhfFvA2Zx80ncunACF1sv5SeGKbOCbygucJ0KEWL6PppjtXhMbHoiIA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791976248;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qM0l6/IAUEOjZn+YPUz7c2KjLxXoTrUiBak/gYDTM2w=;
	b=NB/JqReqJmZUZKBdu8+ILRArkQZ8XJ8n58TGQnq1//rypoiZjbnbn2XL+w5P30FQd9iM
	 A0YLG39Ct/gZnjP/wEddqZbldxN+Ua9VjHrRIi9i5a746haL/uHdoboM4VLQvihTzO9fi
	 SmyRTqR5p9zeg+/RUM89ATlogcgYU0WVAW4PZg1o8PNncOdNvvQEgDnyhyhnT5btg5LIV
	 rZ0biWlj64AZSdQDIcZJtkp5Dqk2Zm8dgfhzHYhIQHOZCA1DhxVgJfbEDCugDw2jZqLcv
	 8B25OMJC1Z/y4nPhb+K5vWbv2u/JcdB1kdYbasQuSvmicClgGyH+3AnBFWgIz0S/ZfA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791976248;
	bh=qM0l6/IAUEOjZn+YPUz7c2KjLxXoTrUiBak/gYDTM2w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mAaKSFhJ3fK6gR+sGqyEk5GiBvZLVfHXRecTMrj336+83Hgz4UcmAFBjs8sDqRPYt
	 HXCcbtn/QwE34OHfdUKjT3Qc348Gp/vHJULNPFHkk1+6PlHfIuANFJDsBdRMcDUnM+
	 K2YRCUH0Y0zIuLNajZQU0ZKGCgPqtlfVWNAtqbXjDWgwhu4HNyey/BkMxkCp8Z6CiR
	 sQpw49Ve2+dOyPhzGdKLEHxgXS/ILew0nEBcK9nHGPZwHBpDxuAtENnXPiaYl73F+X
	 G1tN9wU6+fk+gNBKbgz5I6jVj7Sr/qjxpeBF3jfmRcNzbkDXXfIaQlTzagVpEtu02R
	 4luu/wgNdqZ5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32A33807A6;
	Wed, 14 Oct 2026 11:10:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 959A51BF9
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 11:10:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 881F760728
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 11:10:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VepyCqnbTGIt for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 11:10:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8DC326072E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791976246;
 b=a8sKKQQ2NTJ74cZPzF4RapVw/Yx3wSpw4cRheFc0sQx1JouEFLYvb8R6xZy4fGzOdEc1
 krClvkEzXinKWdom9rwgJPUcJeCda+RkyqXuPGRBcN3vbGVzxfQN7Rnc/6M+EmFQXz0ar
 K4YpaePfALu3yA+nHO0Ng138WzIQvROiZMr6m3yWjhUahqC/ot9ezoGfvZ6A4pL6ii0xG
 +VANwL093uu9y5g2SI9NDta+wy3rStSgeiENn+vtlZQG8M4gGB29rICC66kjJDT/ydf1N
 TS4t0gGdPeIW/mErIZt0gK6e5AYdBsD3S+33FxRg6HG2ei0qNyD2ZWFGbm8dn5flrhw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791976246;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=qM0l6/IAUEOjZn+YPUz7c2KjLxXoTrUiBak/gYDTM2w=;
 b=cn9Cy3ugkoKfIMnoFm33oSzHS0Uvb4ExVTdEwei0iE+4DoM5s+XQrYfHAu0Q6YnEpwDJ
 lllGIJ8xzVPgWRxDt2lDO2Thdp72w0BPeivH6/nWzgP435xWO9WYMWZSsqY54263MCvSK
 V3WywQF34kBZQuniSwIbvbefjnoGJXK9k0WbPRkodh54UKnHcppLI6N+NpZDkYDrjzGg2
 +FEckSHZCuzqIlRllfBODm93t6U5M+0WibVWwX/ujUTlSqo6ika0v+P66qw03x75oxzMs
 RlclupTkRRblzRVTVIkmesxwnwFq2Q1mHA/scdRR3NLfIlqRmWrTntwccwyDSmhMKFg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=i48r1UJq; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=ghidoliemanuele@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=i48r1UJq
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DC326072E
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 11:10:45 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1af482519so13170615e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 04:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791976243; x=1792581043;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qM0l6/IAUEOjZn+YPUz7c2KjLxXoTrUiBak/gYDTM2w=;
 b=i48r1UJqGCUeYUtT0Ooe6mxb64xf//v9P6zI/iTAAEHdJq7dHSjX4i3J3RGLEcr2sV
 N38g4TIGyVTEh8+2AXUkylHUWgOTyc2/MYt75fB3Pw3WyAUipUdsEr+lvc+SoLCZlDVr
 zCnMxr+YECziqcrb3+6WfUgGVFmmRbCNWfjf4YQvREdjJmU6blyzZ1i5POBnOQMRaWJc
 lJVT7k5/W07zhFBwd/SpoZGexXxcrlGlVMrlPlq5GtcekDWjPzVr/keQINYog7j75nK4
 uls2tGsIn1CmMHS6oleeBnwW43jn9JyZfZd6v08KWEleoLmnT4Xa+HYMRi8P7MmaeYkD
 U7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791976243; x=1792581043;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qM0l6/IAUEOjZn+YPUz7c2KjLxXoTrUiBak/gYDTM2w=;
 b=Gx7DT15e4wbB3zpwcAI7gQoJtutctUHqUn2veROqLSDKll8vcEifFyyW9X26Z8rI4Q
 OALXHceqjI2qgP0GJsPkhxDiHNQCIcSxU4jInQ17dTV+W/22gEFjn56KrwswV/rhkCHH
 fzJDADQ20sASzoX6UsM3vXxzjjQRXXpBj24VYGamBzIwXXwwlwjiqCkDHtP4EvH8sL+a
 hGoOXzZOhQ0ahqN4C7nma1hYFOYX1NOC28vgUndHt71G1VU4ci0iBAGRbPpS6P150+4p
 ZR2aUJa4flWqkUMdRQo4kkIzQ4lP8Q0Q8ZNAvewOEayytiXMiHf0LkzQYyYXbbrrepfo
 Nr3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsd5mJ4SpFPHXxCKUkqk7mkFBi4fbtqlOYrsj1jVw/sNKIIEIn6dnZ7OhQogjP3QZ6rdDe4R4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKewOMIbKgISw40bBSZY/7LPRMkMoAxI7DtsBriw2YHbYw5uYAQ
 KVOaPqR/+oTXp3GEIkwL5tTrE6emIcpdrjYG2dZ6XvwBHt5h0+jjbmtt
X-Gm-Gg: AYBFou0prsWj3/35oLdzfwLHsi9E+23IOhDbD1I2uV+3UTRhGW7iYhQZ4pZSW6n+DR0
 efuCfeTD4x1/AXPc+zIou6WNOxUFl1QbNO+ykLp1pqIOmBKCtwYqxAri2YBurSewwzvgegWJfRG
 ++kKctCa/oeDAAMGlTU5Mtk9XQ+MTSIgu2Fubkt4YgeSxYsECZlFqTWxHMrDA8vJonEL1wUGhJ2
 6KdP6mEOu2njEOV6AyX0Prjr/5Qn5hIxF3pBb00ji0viHrGterONtxYxuqPM1bXZ5XLrzm4IS5o
 oAvA1M761jWj8c0O+MCTKJLrmPwLf2ANa50odcdlqtPPhmBX9AbUGPvo62d4dZTx3AmbWENl6/H
 +YJ8SMehwOXRbFpwBvgtYlQZ+ZYTmXvEfVdlC5pkuT1sO6TCuHpKAmY/jtjRgnnOS+LKO6SDp74
 i65nLjKms94u1fJ+nOMxqUAcozAFT6lWL5ttsEISEUhkstwkUW7ug5AVsf88Gk7Z8xs5GWQAaDR
 NcMJz6OKX71tyMzjqnp06rfVXaHkmFJcUBbokY1CZju8R8kA3XMJGvtmaGIJA==
X-Received: by 2002:a05:600d:4443:10b0:4a1:9c71:9f17 with SMTP id
 5b1f17b1804b1-4a19c71a176mr143271545e9.9.1791976242877; 
 Wed, 14 Oct 2026 04:10:42 -0700 (PDT)
Received: from [192.168.1.3] (host-80-180-152-220.pool80180.interbusiness.it.
 [80.180.152.220]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be964dfsm430861755e9.7.2026.10.14.04.10.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 04:10:41 -0700 (PDT)
Message-ID: <6a494ecc-9b3c-4cf7-9221-257c3001440b@gmail.com>
Date: Wed, 14 Oct 2026 13:10:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] toradex: {aquila, smarc, verdin}-imx95: Enable
 caches in SPL
To: ye.li@oss.nxp.com, festevam@gmail.com, u-boot@lists.u-boot-project.org,
 francesco.dolcini@toradex.com, emanuele.ghidoli@toradex.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com
References: <20261014100915.3470159-1-ye.li@oss.nxp.com>
 <20261014100915.3470159-2-ye.li@oss.nxp.com>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <20261014100915.3470159-2-ye.li@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 10/14/26 12:09, ye.li@oss.nxp.com wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> To enable icache and dcache in SPL, add the definition of secure DDR
> space which could be accessed by SPL and move arch_cpu_init before
> spl_early_init.
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Tested-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

