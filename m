Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B0D606A8AE
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rApwgScH;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iizEPIwK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 722E480CCE;
	Mon, 16 Nov 2026 16:23:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vgiw8H5myQXQ; Mon, 16 Nov 2026 16:23:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 76E5280C17
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794846207;
	b=fBlCn4GR2wrxP1W3Dj7PUVm50VAwjKNmRaw6Z8SWSVDkpNrIl9l7UsJiNgGnCnvpIiCi
	 V68u0WrYD88MO/ED8mHSauB48q5bXtF25jNh9v2IF7S9DEyNDJeZVib+uWdGQaN0uZeeg
	 kr6I36KRKMhDRYY7iWIUUYeSmLAN7jflmkuydXMjmbw7DqyNvBWXXnNctFisAiPdseB2w
	 XGQVcMSHohWVDs9Z9P2zV3TOK6F6lgCFPvLzh3PZT53MXAaRmz+E4zX1RguaR6o/HTqf7
	 S/2n5jVA7xzFm8LaRpoCie0nRGc6CKC3u2HuclLX9X96dwjvfJu65SQlZYUlzn5FXhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794846207;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JRK93jDsnD9qWv9m7U2fvvxoD/LX9T2aRnYjSrZ8+r4=;
	b=sY/C2jcXVA1U/RmNPwhHJH15aDmuHhxB8jDqkS1+cCOVW64HEDhA36EjG4Iu+q4CTVgD
	 WFzyERUBjaawAzE+2S0efefa6OI82bvhxRvh3rMYqu71ADch6A0FKadybJc1Y+nKF6Lym
	 j2Et2qEDVH7Fc95iJ8iHFNrbVsNVeDRYrusqElflucd1hTMWu25adf4dpI6znfQ4mHweS
	 8vkuMbkbQVWukzRwdd8xDeLFr1P2bRdkqNAtYUEMFyMjhzdSyYlTA1/1+ARXsl3XCixZr
	 l1ef3p4I5asgOSA9WkHQYqW4EXe2baQp89B4M93p6GJRqhR5elFTS4qNMoXP2DVHaEw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794846207;
	bh=JRK93jDsnD9qWv9m7U2fvvxoD/LX9T2aRnYjSrZ8+r4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rApwgScHQ0WXsP4xg1XIr+c463SO7B4B+dn+Dfa95D/4Y3L9mUN8W/IC65cSqFBBk
	 mQ96L5JzslphHUXDjEuVdn1hvD/7jxrbJuEYSqkckgt7AJsSLBdKr8juvZUzKKrl8t
	 4IDhOZedMkXXr6WDRnsk6pMxhfKFYRmvipythYUL1XwQDTiMmKIVPlN1GWLU3xoM2V
	 xAJikT7KBUjLyZgwDZS2Zdgd99DuzbH9za8s6/t3F6GzYspOAoICmtC6lVxweDIBdk
	 dmt/cfrjkWfcCIKwm7EbSCRQPlGndSIUOk8fqr/JrpFipuq3sESZd9W+OpbMBY+kC9
	 Fyhfia22Pbaeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76E5280C17;
	Mon, 16 Nov 2026 16:23:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C2DCA2FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:23:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A8B2B607EE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:23:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P-sOV1mVXJPy for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:23:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C2C4E60777
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sumit.garg@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=iizEPIwK
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C2C4E60777
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:23:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 14A114487D;
 Mon, 16 Nov 2026 16:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A836F1F000C9;
 Mon, 16 Nov 2026 16:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794846205;
 bh=JRK93jDsnD9qWv9m7U2fvvxoD/LX9T2aRnYjSrZ8+r4=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=iizEPIwK83llUrBStzp+8ekVo/g0jdQfslTZeWIyFjTG9DtayNpeULTqFSILUbhV3
 UBpSECrnYcKUmcv+/ctzN6ekAkTpEMKq7K7/BlWcXjGNyH+YEHOsh8+H0Tve/gbTUt
 GWoxrookpxCIZocuFkR0FbIWN3QgcaNFPlwjPwMHeAljJ43Ht5UVnDoGQnWMCVasle
 c3rn0WHVGdBY2kXh+5rpkvlRMT5aJW9PJAjUCxRMoi8of0HEBYjnAwYvwxSs4cQ57P
 JMnni7nwn2128VDhyHOyNCybujUkQFpL/sB6C29GMdnaUzdG+1bi1Kxa4V+pULIuhW
 vnRt+YdJqwmsw==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 0/3] Add preliminary support for MSM8917
From: Sumit Garg <sumit.garg@kernel.org>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Reza Kurniawan <imkyufie@gmail.com>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Lukasz Majewski <lukma@denx.de>, Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Luca Weiss <luca.weiss@fairphone.com>
In-Reply-To: <atIbpYy2Ql2OzLxt@sumit-xelite>
References: <20260916-msm8917-support-v3-0-35103cb4e01e@gmail.com>
 <atIbpYy2Ql2OzLxt@sumit-xelite>
Date: Mon, 16 Nov 2026 21:53:21 +0530
Message-Id: <179484620106.21534.11246839948134199003.b4-reply@b4>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-16 18:12 +0530, Sumit Garg wrote:
> On Wed, 16 Sep 2026 at 04:16:01 +0000, Reza Kurniawan wrote:
> >This patch series adds preliminary support for booting Qualcomm MSM8917.
> >
> >Specifically, it includes carving out reserved memory regions (no-map) at
> >early init to avoid security violations, A Global Clock Controller (GCC)
> >driver providing essential clocks, resets, and GDSCs needed for U-Boot and
> >a pinctrl driver to configure pin parameters and manage GPIOs.
> >
> >This patch series depends on the GDSC flags series by Luca Weiss and
> >Alexey Minnekhanov [1], specifically patch 4/4 ("clk/qcom: Treat different
> >GDSCs differently") [2]. On MSM8917, MDSS_GDSC does not have POLL_CFG_GDSCR
> >and requires polling the GDSCR register directly instead of CFG_GDSCR,
> >which is addressed by [2].
> >
> >Changes in v3:
> >- Drop "clk: qcom: Add an option to poll for GDSCR GDSC_POWER_ON bit"
> >  in favor of Alexey Minnekhanov's series [1] / [2].
> >- Update MDSS_GDSC in clock-msm8917 to comply with the new 'flags'
> >  member in struct qcom_power_map introduced by [2].
> 
> Series look good to me, FWIW:
> 
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 

Casey, Tom,

This series has been reviewed, pending to be picked up?

-Sumit

> 
> >
> >Changes in v2:
> >- Change license to GPL-2.0-only
> >- Mention the source of the ported code
> >- Add error check for out-of-range pin selector
> >- Use macros for RCGR address constants
> >
> >v2: https://lore.kernel.org/u-boot/20260912072619.244101-2-imkyufie@gmail.com
> >v1: https://lore.kernel.org/u-boot/20260910095339.110427-1-imkyufie@gmail.com
> >
> >1: https://lore.kernel.org/u-boot/20260715-gdsc-flags-v2-0-27704470a24c@fairphone.com
> >2: https://lore.kernel.org/u-boot/20260715-gdsc-flags-v2-4-27704470a24c@fairphone.com
> >
> >---
> >Reza Kurniawan (3):
> >      mach-snapdragon: Carve out reserved memory at init for MSM8917
> >      clk: qcom: Add Global Clock Controller (GCC) driver for MSM8917
> >      pinctrl: qcom: Add pinctrl driver for MSM8917
> >
> > arch/arm/mach-snapdragon/mem_map.c     |   3 +-
> > configs/qcom_defconfig                 |   1 +
> > drivers/clk/qcom/Kconfig               |   8 +
> > drivers/clk/qcom/Makefile              |   1 +
> > drivers/clk/qcom/clock-msm8917.c       | 210 +++++++++++
> > drivers/pinctrl/qcom/Kconfig           |   8 +
> > drivers/pinctrl/qcom/Makefile          |   1 +
> > drivers/pinctrl/qcom/pinctrl-msm8917.c | 645 +++++++++++++++++++++++++++++++++
> > 8 files changed, 876 insertions(+), 1 deletion(-)
> >---
> >base-commit: d27c992cebb95bd903d09f3d1da55032a7a145da
> >change-id: 20260915-msm8917-support-e56f0d21881b
> >prerequisite-message-id: <20260715-gdsc-flags-v2-0-27704470a24c@fairphone.com>
> >prerequisite-patch-id: a1b270485786a326cb40fda882935fcc0fbf3bba
> >prerequisite-patch-id: 1d4a1450016d914394cf6a7e24ec9e5bc12fe80a
> >prerequisite-patch-id: 568826d73bd992c6ff16681ad33e6891e25af5f5
> >prerequisite-patch-id: bad5df259c02085a5aa51d130459ae1eecd0f638
> >
> >Best regards,
> >--
> >Reza Kurniawan <imkyufie@gmail.com>
> >
> 
> 


