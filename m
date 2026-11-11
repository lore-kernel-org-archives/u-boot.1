Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481A7606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Z26v8/3x;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=o/jeR7e4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 243FC80F1D;
	Wed, 11 Nov 2026 15:32:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xSkPtksIcKBm; Wed, 11 Nov 2026 15:32:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 702CF80DA5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794411134;
	b=Sj2LCRrUfSPcw/1zZhpqpku5J5nmGkafVgtfZt2hSVwTVOCq3EaUe0ZWuhY3Z+Fjzimf
	 mKBuEbMRPd0BBwtq/LW4spDSgjADKP1aXyWYY/oEIpJQOaYtl+bPmv6pxyJPK+yoGSCNt
	 G6M+q5AJqdYTeL7gmsAZ0YGio6Cvfcpi/+5h0LsGc3uKC8+UKlyhyxZ5hU5aJAN5S1WcM
	 deedlGQ4HLKJ6xrXWO6DmNzwGmjcv1JMpodBiolq9LEEBFd6zb7OOh5YQf+R0yWOOOqLZ
	 OzOHzXq/E7FURMmgvMLLfVenzXFUNCbh14TLi8mqCwpQ+k12K3YEYWRjjVjtxnRNsXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794411134;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/UETWCIA1kTdDQ++fWhaHevkUbPUq3Ml42/2qXPgSwI=;
	b=rqXAhHfWey9bTjd6wB2stD+9jtogjysLfRdkXmbg4+hiaO3agMxbqalCWQ7Q9o2Un/ve
	 73XKhalL853uoakFPSnA7IS8vbPHKZ0B3rFhJfFFBjIaqeVcxG2qztKIufuVUa0UCWtEr
	 oHwsezAA4OMI8pjjukvs8nER1HMQhYCSrTZncF5tgctS6UwBpMfzf4bWVbY1gXS7Xoo0R
	 ylAGp1En0mEwG1CNJtJcxswBS8ik8TEjZ76j2y25b35tj59IdiLBPvqfTWsreKmQfN50/
	 Wc6pAfiKKg60OJ7uvCmhLaTYsAU1Xx9Ld5qysa3bbgSpD8Od1TMc6MxI1opwVpTDfxg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="o/jeR7e4";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794411134;
	bh=/UETWCIA1kTdDQ++fWhaHevkUbPUq3Ml42/2qXPgSwI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z26v8/3xYbZ4/GZ3arH/ICODzTZAk647gfvrzRF0z/sWXnJXqdwpGGI/cxo1J1YnT
	 HSGyoToVhfGJgohQB4hfytlJOZl9Y+fdpyCsJucWw48sLxX3aUhyUeLGQQP8aFaKV+
	 iQEWXD32gtvZcCPdiOLtRhbj0HAB4C5p/PCPmdqdOVY1mJlHFG5p9fCl8dSWnEY6Wn
	 AAXi7KKkLo1Y2VJBBhhaY0UM1slqOdfNZwEB2B/zAIbDZVMsCqfJdW3w9ngWMZ6jba
	 fhvUpmmojbDWQFT6A8aQ2Ak4o84BKDKBeygZOVIZ8SkX82AO9WzP6e7+oxamHookj6
	 0bSo/WU6bKZ9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 702CF80DA5;
	Wed, 11 Nov 2026 15:32:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B091D31F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:32:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 958F2811E9
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:32:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uij2ukhYeqRL for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 15:32:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D7C61811E0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::31; helo=mail-oa1-x31.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=o/jeR7e4
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D7C61811E0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:32:10 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-48ed0b68895so2144725fac.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 07:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794411130; x=1795015930;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/UETWCIA1kTdDQ++fWhaHevkUbPUq3Ml42/2qXPgSwI=;
 b=o/jeR7e4C6jnLogYV1YoqMRJiGMQUPV7Mf+3SX7CJQSq9jRgmd748sSr+Rx7z6ZQPE
 E2Z+Az2aR/h1mNbDRSG7losIPEnGHkRhKQIl1sV2x13vynPn8U5B8bwQIFBlQx9iNsW9
 5ucmt0aNItUu9o7RU7zFbaLenRY0Szf14+wjy5JQFCSYyf5oZMX4bGL0NiqQbVhBIgce
 OkDs3LNO2KmcjcZ4EkenuEPpP4+bkhbgszOU3NrW8XEZ4BvsyrVHE+UlnLwDG+H/fdNY
 GLxay78YPRtz0KqQa8axMH4HTP1z1jWGlM66Faryj00ka7lQg1NTofT0h5Ix4QPNSvkz
 7d7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794411130; x=1795015930;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/UETWCIA1kTdDQ++fWhaHevkUbPUq3Ml42/2qXPgSwI=;
 b=aYrgbRt8XBtN3u6VBZDXyAFUwuSCd70b9y6mKsT+IW2J8DMetqRc9B6AkzUajyQis2
 ytHiZz9wy+PyjT9as0sOFHFSPCAXz4Adp3r1OEnqOfEUN+yg1AZOFsbqu45viecdbo0d
 RZO5lSnOrSCrOnidBH4wUe8SSUUfzWSZ8SWAw+HmsvaGbIAxgwvW7sMHC2mO6vnZ4cHV
 oAK+gwu2K2CYaxQSy6of1gzLC9rww2glqV5i67K27fq1eKNuO13SrJc7/0CmiQoizMjL
 uv/+HiSBJkDKgrlqfAWHkgEOikJ1A0DIjqzuQqKILg5gdo4E4xhnU5pyoskRKvrTMmnv
 uiew==
X-Forwarded-Encrypted: i=1;
 AL+hErHxB/91qG1NQySM5j86cmkASFpFxbRaZqqWS0l5AKOEVOsj8Tbp9upsiJmffvLl+rxBcwAyLJU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8PkRMFzlZDRjcC0ZZNJKUcC2doyxKAaBmJVDtbz3hrrvW/hwRq
 5SvlroWGMClqFpCHQvGDvcUG/QXOBW6iiZ44tQUW3e7ol6W238R9eY8kxOqtNNywz4c=
X-Gm-Gg: AYBFou32kjm5g/4xVWR26u6aeEqNKXY9d/4z6QZOUF20XsALZw/5RfGhKe4cTCW58+x
 mKDomZ6VBL4O4JnX+rBugX6KXhuq1YCidjP6u6WXB9AiOzagqNwK48reTeEtNyYB1RGmLZ+chGF
 WIo+FvdY8psqLj9vbGXRcgIlne7XkSOXEzo+s5wl/UOzXRppo9KUkR5YKcgjbwkGlhou4Q1IP0u
 vMnbInbtknoSd/asZZfE1c9CVWjVeu5w2EBJrBobydWpEmBasc/RV9wIc8drKWC8mAtBjO4P1IZ
 RKzFc7mVLx0VcOvKS2Gw6mAdwHHWY8Uu+tjMIdRJpx+3X61ho7DucxXezrinukg3FNkugj/63Jj
 VO8P61rubGTfjO6MdkM/6raud2+oCBIAGkPZ9BmZV91i4x7xBl8WZOeUskrXCJMKjQSSdWmRV3D
 vNoLO2njoU1SJaSpUFewq2TMW/Vug9HK6ba00cWOon9XNxCRf5Yh3FkAzsVrARA3cs+DxqwGgkH
 eqeFk3IELB3WmlQvKf2MTXNpWjPNZQ4hnN1HioZqrmtBuK+W/Fuk/mNTpRLoaSsxKgVrjYTrpAF
 V52nPTCEVkl2A7R4uCXwbU5akyN3yfaCOWC0rlpxPNKI0WQSjsBgJx0WBY+pCtDTgCoFV+KQB2o
 6JpA=
X-Received: by 2002:a05:6870:15c7:b0:483:bdb3:a524 with SMTP id
 586e51a60fabf-4ae46803605mr2200423fac.4.1794411129822; 
 Wed, 11 Nov 2026 07:32:09 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:7fea:2979:c338:d2a4?
 ([2600:8803:e7e4:500:7fea:2979:c338:d2a4])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ae22f6d240sm3597716fac.5.2026.11.11.07.32.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 07:32:08 -0800 (PST)
Message-ID: <c691dc34-44ab-4024-9a7b-c6498159ea01@baylibre.com>
Date: Wed, 11 Nov 2026 09:32:07 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] configs: add a Genio 720 UFS configuration with
 OP-TEE RPMB
To: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jens Wiklander
 <jenswi@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
 <20261111-genio720-ufs-rpmb-minimal-v1-6-701a62dfa034@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261111-genio720-ufs-rpmb-minimal-v1-6-701a62dfa034@baylibre.com>
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

On 11/11/26 4:21 AM, Carlo Caione wrote:
> The Genio 720 board already provides a merged UFS device tree, but its
> default configuration selects eMMC. Add a UFS entry point which reuses
> the common board configuration and selects the existing UFS overlay.
> 
> Enable the OP-TEE client and Qualcomm UFS RPMB transport on this UFS

Is it really "Qualcomm" or is it just "upstream"?

> variant without changing the default eMMC configuration. The device
> tree already describes the secure firmware and its reserved memory.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  configs/mt8391_genio_720_evk_ufs_defconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/configs/mt8391_genio_720_evk_ufs_defconfig b/configs/mt8391_genio_720_evk_ufs_defconfig
> new file mode 100644
> index 00000000000..47904f93e91
> --- /dev/null
> +++ b/configs/mt8391_genio_720_evk_ufs_defconfig

I prefer not to have a defconfig for every possible combination of features
we could have on these boards. It would get out of hand with different
combinations and make CI much slower. For example, here we would also need
another nearly identical defconfig for genio 520.

Instead, we can add .config fragments in the board folder that can be
combined with the one and only defconfig.

> @@ -0,0 +1,7 @@
> +#include <configs/mt8391_genio_720_evk_defconfig>
> +
> +CONFIG_DEFAULT_DEVICE_TREE="mt8391-genio-720-evk-ufs"
> +CONFIG_DEFAULT_FDT_FILE="mt8391-genio-720-evk-ufs"

We already handle this by `make DEVICE_TREE=...`


> +CONFIG_TEE=y
> +CONFIG_OPTEE=y

We can probably enable the options above in the common defconfig.

> +CONFIG_SUPPORT_UFS_RPMB=y
> 

Then this would go in the config fragment that one would add only when they
actually have RPMB set up.

And how about also enabling EFI_MM_COMM_TEE and CMD_OPTEE_RPMB there?

