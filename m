Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD4BCA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 19:02:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 193BD40547;
	Mon, 12 Oct 2026 19:02:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ecW-wyuJP3Md; Mon, 12 Oct 2026 19:02:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1964640535
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791831735;
	b=JFQlqjbGcSrxENXC7bef/g+Xn5WQwcBra+C0cvOblj1JzaqSWHczCQI0eo/0X84kflmW
	 JdtxSjLNlJw65N1EVzGi8ISN3WxLKn3Jk7rrdednaLaewxvwv4pHchHscflIVx8mS6CaJ
	 UjYV3ykFTkgI8A8oKlyUqriqHH4Kmi0tcI5IlMFViVdjg2rUMFWi1QVwUolVnOU8q04H9
	 r3I+Hh+SRgSc4M1rY2eWjGjJTHS6WUypPCqSIXaLDz007l//eD1g0zcJXRM1NFcZ9znZ0
	 aJXpbbyLUVOrCBjP1zTBBREnj/RK5BiZQuMTRGmn8QK85l9WxbPH/hDHZQo41aRkU9A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791831735;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8II0Wg+MOx1/Fw1H4uXY6NL+Jgfywv6je1zDHV9GThI=;
	b=hv49ApT5evlbDwbG8jQ6VRJAZJ6FqR/zdvRNAWdZCzNl9/noeD0VTy4s8E1xZCMU+i1l
	 KpVbAUij4wJrOG7+3UCP+uLoQMEzmbPB90KNZEQeyfjOd5oox0qI/ySKpZkcPTF/vWEz4
	 L3UzaG0G+CjVHrDtPsYmtPl1ycdl+olcUu1aoBb/uJxQEkYzjeKWNLXAWhCLuXUDl5Xc1
	 TlxV0Baq9ZxqE1mDzo9kbdcHazutJpuzDq25f6ltMztJaSv1HGuAM2/QVGhItn6byr+bN
	 kYwS5I14/I3elpZ/apwTxIZLYmXigzfYmu0UgWVGSvO/R52+lnsDqaygP8ABkXqqSwQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791831735;
	bh=8II0Wg+MOx1/Fw1H4uXY6NL+Jgfywv6je1zDHV9GThI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j2Zi67EwOoaYMc9SwZMiCypF0DBscyU/GwORSEU/KXCWTKIr104IqxFRgezSqAcma
	 WukDU8pfv879cMO5LpXVmvZehb0OLA3q+T3dU0J2/P8aPQO/JQedo9KRNLKk9Pr7ol
	 /DcQJaPKLWavGkgMYFG4+z/PG0kyIOI0fZK1UkZbd5AEWyS44Zwp4I1n1zmh5v9x89
	 0crZpVpTB13BRCdW159t0dWg0lKr/f2VK2QzhEV2jMdzmQkAIXc5i330fdqbwLsqYz
	 OEphmEG9JFemklwn8eOi44c46yzBdEHbMfq1G7ezUBoUL+FvQhKhvTuf2CM7VtMcOE
	 fb9JYU8wn80gQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1964640535;
	Mon, 12 Oct 2026 19:02:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BF692A8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:02:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C16380683
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:02:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r_lJAbPzRrCX for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 19:02:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 60FDD80A65
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791831732;
 b=b3m9zKsDDrlrR7nKClZM3Sy93T33pyNZL8+1Blkh818b8VQ/hPn+CaUVBm5hRexMCVBI
 3/6AG6TpPUyqXWXdk/6HrH/Bz5yVn7YpN+nV3XM7gIZn4OcJ21eTS8rc/t0k/9Om+dW8t
 2Nf/8BEXOwsb8/bbbuc8Z/24vS4Wf9AEP2QB2xoWqezenVKObsenG0H68aXTsamJGmh2T
 5bw7jLULd2MtPUqXk0rLPzD4ndg1eUx1m+ytSyvkxKaGY7YVK5Ww7t6gtvUTqmJXSWdpj
 Vb0p5hokTOEB+Xc4T7Z51jGpbO5mDhQ7SIDSGVyFVcR9K+5hXCdTp/i/X3DzpxSWBqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791831732;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=8II0Wg+MOx1/Fw1H4uXY6NL+Jgfywv6je1zDHV9GThI=;
 b=GxN3gXDfy5dUu+VHZc62qL1KIZ141lZEiMQ1IIHsQupMTwMEXVJ2DnSlEtG5YvDNNO1D
 aRw1LI6VEdffonngTfYHkawUQUpAljuIsxhKJHBS0ImO1CioyWIQbVW6nlb0HhV8pbhZV
 +vS3uun/AzH351EE+omhqm0rgg84dh+Ztj47IEP/7+W2+/LE1UyUUMRrvN4Ijmt0UgoxX
 rRtwdb8L9zG6EZZhDpF1vscBRedgCTcSF3u2nb2ERo0/j3GTRdhVZvKwruJNfFYep4oGs
 4fmrQI2mz49zbKLF2A+ZyRzY6LUJoGBbRK166N+1cgc9PxT54I7+Tp9dybr0r/hFtYQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QRPp6ncO; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com;
 envelope-from=nathbappai@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QRPp6ncO
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com
 [IPv6:2607:f8b0:4864:20::122f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 60FDD80A65
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:02:12 +0000 (UTC)
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-16ad92569b5so2081523c88.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 12:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791831731; x=1792436531;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8II0Wg+MOx1/Fw1H4uXY6NL+Jgfywv6je1zDHV9GThI=;
 b=QRPp6ncOy15W8qYZ2/o4VBHdO8qN3C5G4snRgBd/52xZI48BJOmCrpX0fkPFpIQv+k
 72GMF/jzwsz9EYScx454KnUy7q2fMzb7r8foloktdFJMoXgKHMPfC0QPzl+7fD+ZQ9+v
 L5tS9FN4Ur/CkiKIbyA5Ja5FHxZxz9bP6pLqe4S6SN8D0d53ITLplMKfwqcqxMIKNixX
 OfeCD/SPQY62SmSuBrYA7HCTNxDJ4MH2J5DRsfuDu3k85THY7JTgykEwfPdlcDGKfYVD
 E7yiFHgGxi2K0ViDy+RrP5aiUW+YNbUVWZsirtvhqxNYreblmS75aQNcKEHQ0ng7Go2Z
 NX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791831731; x=1792436531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8II0Wg+MOx1/Fw1H4uXY6NL+Jgfywv6je1zDHV9GThI=;
 b=vvm5OBNGbcOJqKMkJC+dT8y148uw3UCUNBnWllfrmo5g1H2KZIZb6IXR4K+JtOoRb9
 4QuoYlBssIC7x4WO/zdw+u+TKE5vJfkNOtc5gqqzzcGROYPAuicZkvIhDoo/djABA+FE
 E32ha2ouY3LdJ022grH6wIM6NwxIt/I/CwttsN+r3wYAVMFB/9mwcPq24VlILdmVFsAx
 oN9TomnVeNdCxc8F4DQ07WY9379Wz33Lah03T4aVYUBKMXQ6U6+SA0XhgerDBl22fW9o
 e7K9PWf2E+jIM0s7MXV/7K/5FUFbE7SBxl/SnLb0NuszyOYEvRMblZFcLNOKuMxDGv6e
 RNlA==
X-Forwarded-Encrypted: i=1;
 AKwUvByPk/6NDjcHDiIcJra77zNbtRyuIw6lcndxnhXyiM8CWjNhIpielPCKuHmRu+J5YNo9GuanvmQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIt5rjHZnT2Y0F2hc1b1OlhkQgj4abJg/z8EioGn2lDvnaJL1D6
 X7XGgvgkJNCM8b4fK5nHgbrVj7iak2Ms9VxT/1F0Z4Bi30kFhUkTVIvf
X-Gm-Gg: AYBFou2cQpfLSfLjduS/zrwGYcMsyydGYGstYbeT8xlUbW2PFqIZ4bIg7yezpj5tMdb
 iU4Uc8SPlny/TBhLJMlDe93vOOcWjcGhnR1fNJLo6TGkzky9TOnydBLgRihMyygLfQk8YUxE8yA
 YwJqBcW99YpkSmKqPSrWWNbYe6Ns+745EKHDmZsgiX3F8FYf3BIH3rslemQD6oPcvYmX9HQdRFu
 gGjpBW31WL6a51uXhkryUBxJvRafg4wtMnyQMxDpg5bGsk9ocBPd8Whl2UYjglieXkjX4G9KSCp
 OyIuI5vRDgJ3ARG3V98wfZL2MwFOmQC5+/1GOJz5EZ1x6f/K02j6n3a4Eg9gqJbTmtMPWXCfNwH
 OTqnbX5eEx4lrPwbfKJ5o+tXc864bxpMsulwG+zmP9YCKXER/JIN4+tF6+yqarzsD3FkUSjnwKP
 6yEVyjzULqs+NMEO6MEYI5eGJTmtqMtB55AaTwGkNyTjDvp1Xf8G0/UXBAiYEiyFUxnTbYI2+Wq
 aIACtReRS9dDQ==
X-Received: by 2002:a05:701b:424b:10b0:144:e246:a0b5 with SMTP id
 a92af1059eb24-16a5e968b0dmr14396102c88.40.1791831730820; 
 Mon, 12 Oct 2026 12:02:10 -0700 (PDT)
Received: from localhost.localdomain ([223.223.143.131])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-169a442ac67sm47846889c88.18.2026.10.12.12.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 12:02:10 -0700 (PDT)
From: Biswapriyo Nath <nathbappai@gmail.com>
To: Reza Kurniawan <imkyufie@gmail.com>
Cc: Biswapriyo Nath <nathbappai@gmail.com>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH v3 0/3] Add preliminary support for MSM8917
Date: Mon, 12 Oct 2026 19:01:45 +0000
Message-ID: <20261012190147.99117-1-nathbappai@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260916-msm8917-support-v3-0-35103cb4e01e@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Wed, 16 Sep 2026 04:16:01 +0000 Reza Kurniawan <imkyufie@gmail.com> wrote:

> This patch series adds preliminary support for booting Qualcomm MSM8917.
> 
> Specifically, it includes carving out reserved memory regions (no-map) at
> early init to avoid security violations, A Global Clock Controller (GCC)
> driver providing essential clocks, resets, and GDSCs needed for U-Boot and
> a pinctrl driver to configure pin parameters and manage GPIOs.
> 
> This patch series depends on the GDSC flags series by Luca Weiss and
> Alexey Minnekhanov [1], specifically patch 4/4 ("clk/qcom: Treat different
> GDSCs differently") [2]. On MSM8917, MDSS_GDSC does not have POLL_CFG_GDSCR
> and requires polling the GDSCR register directly instead of CFG_GDSCR,
> which is addressed by [2].
> 
> Changes in v3:
> - Drop "clk: qcom: Add an option to poll for GDSCR GDSC_POWER_ON bit"
>   in favor of Alexey Minnekhanov's series [1] / [2].
> - Update MDSS_GDSC in clock-msm8917 to comply with the new 'flags'
>   member in struct qcom_power_map introduced by [2].
> 
> Changes in v2:
> - Change license to GPL-2.0-only
> - Mention the source of the ported code
> - Add error check for out-of-range pin selector
> - Use macros for RCGR address constants
> 
> v2: https://lore.kernel.org/u-boot/20260912072619.244101-2-imkyufie@gmail.com
> v1: https://lore.kernel.org/u-boot/20260910095339.110427-1-imkyufie@gmail.com
> 
> 1: https://lore.kernel.org/u-boot/20260715-gdsc-flags-v2-0-27704470a24c@fairphone.com
> 2: https://lore.kernel.org/u-boot/20260715-gdsc-flags-v2-4-27704470a24c@fairphone.com
> 
> ---
> Reza Kurniawan (3):
>       mach-snapdragon: Carve out reserved memory at init for MSM8917
>       clk: qcom: Add Global Clock Controller (GCC) driver for MSM8917
>       pinctrl: qcom: Add pinctrl driver for MSM8917
> 
>  arch/arm/mach-snapdragon/mem_map.c     |   3 +-
>  configs/qcom_defconfig                 |   1 +
>  drivers/clk/qcom/Kconfig               |   8 +
>  drivers/clk/qcom/Makefile              |   1 +
>  drivers/clk/qcom/clock-msm8917.c       | 210 +++++++++++
>  drivers/pinctrl/qcom/Kconfig           |   8 +
>  drivers/pinctrl/qcom/Makefile          |   1 +
>  drivers/pinctrl/qcom/pinctrl-msm8917.c | 645 +++++++++++++++++++++++++++++++++
>  8 files changed, 876 insertions(+), 1 deletion(-)
> ---
> base-commit: d27c992cebb95bd903d09f3d1da55032a7a145da
> change-id: 20260915-msm8917-support-e56f0d21881b
> prerequisite-message-id: <20260715-gdsc-flags-v2-0-27704470a24c@fairphone.com>
> prerequisite-patch-id: a1b270485786a326cb40fda882935fcc0fbf3bba
> prerequisite-patch-id: 1d4a1450016d914394cf6a7e24ec9e5bc12fe80a
> prerequisite-patch-id: 568826d73bd992c6ff16681ad33e6891e25af5f5
> prerequisite-patch-id: bad5df259c02085a5aa51d130459ae1eecd0f638
> 
> Best regards,
> --  
> Reza Kurniawan <imkyufie@gmail.com>
> 
> 

I have tested all the patches with msm8937 Xiaomi Redmi 3S (land) phone.
U-Boot can boot Linux and fastboot, USB serial console, SD card work too.

Tested-by: Biswapriyo Nath <nathbappai@gmail.com>

Thanks <3
