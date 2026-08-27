Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2550C61DC2
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 12:54:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D826160785;
	Thu, 27 Aug 2026 12:54:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id soqj6YFVtFlE; Thu, 27 Aug 2026 12:54:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787835284;
	bh=FxgA+y0k5r50+WB6t5cNU9PUXD11FBvAsT40TaOEeSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TIpntYjjwEif4/ICpfryBZNrwJZaHZqE4Av20F4V2ZYsLJp9joW+miOA//XpxVSOz
	 ZfvOVbUM2BElf01EDwYU8T0hqkWSq+W5eOuvtj7aV7IvkURutnKp4WESdzi6s7+Lbt
	 QnodnBtPuECtetvG+G3EWj+fMkDKwhW+hoMiJxjjHEkdIeK8JSK3VteXlwk4kMlQS3
	 wXHm9RwhL8vpmp6yXEV4yssoZtELMgAXlT6J4Q+4k93D/8g/7aTCvFlrcm4WJsz62z
	 wpYV28zOkoDOrguPUywwqeWYOYU832DC+zawC6vEBzmWhtMq5vXr/2oPg1yuv+xsDc
	 LCxvM3GOGyI2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3955B606CC;
	Thu, 27 Aug 2026 12:54:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D051C7AA
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:38:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B085B80DA4
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:38:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yKJI1bqmoF_d for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 08:38:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=sOvIaxR4
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C8D7680D0B
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:38:35 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49b8ce9b733so2164615e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 01:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787819913; x=1788424713;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FxgA+y0k5r50+WB6t5cNU9PUXD11FBvAsT40TaOEeSo=;
 b=sOvIaxR4kOtvMzdSIbA41TsFVPfKLYOHbo61j5kQ5gW7IkvBUm9OVk8ku4Seus21cA
 JX5MHfyGD7wfmQVgJtFa2UYRHGX8wC0/u2j2DwgOY2g+DOooNmxv7UsVpl3cKj6fWm4Y
 mql4QTlHbn1G6b/1vQ5UMMvc+1mvhvseyCqqVkAwLnYeaBR6MabWwAVuwIn0JSlZE9ap
 /i9KNOeL0czPfn/b+gw18bAdpLHkzwTtiqsMsiPuzv58UzhPy/dueFsvU2rAOrR5jfjS
 SqHeGgROCkzpD0gR9wplNwhHmx4Z1ssJUK9235vTD7DwAJDDZkjKnO0XFLNhBXct+fMe
 YReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787819913; x=1788424713;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FxgA+y0k5r50+WB6t5cNU9PUXD11FBvAsT40TaOEeSo=;
 b=IOiYK+ycEnHWRM+rAUZdtmozyxK2D/ppx49XR+5DY+vIst9Le1Rv37d/vcCmNR79Sj
 7sT/HMZ0aVTVVmOWOFW+SFHJ8Qb4anCA5yQI2tCwqomxD5mJFg8Ad0wTf7av3Wy5n4bO
 POh44bHOrNZuMvIEe9c8PvF/Eyy2hL6tb4Nioiv9D5cxr/pdyb7ivfIX+vcrEGERF19l
 CGzqjy3GZl6CEmRPfb2h1XwCl//+gGtgBNu74tRolYkv5pq71H3JATaowmmoTq+XoHrt
 OhekjHZlLpb8eHjHRjazStdXT5Lr7od04IojQN6urjg8b+TDuIEcCURMuQX7iN8gAdpY
 CgEA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCmFj+h9O71k+e1GDxD62KDAi2nk7sjM9f+IWI5Zf6GlfPE1okyKNz1yfRX4PwMpfFv7EQ0yo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mWzRC1SXsaICPm0rHnCojNSJyPeooDdIFn+Vik7womvXeIlPqn
 4Nrp4RiAfBmNWW4dAvRh5Rnx/X7LcCteg7N2Fjo3sChbss5nOMBUyBu0
X-Gm-Gg: AR+sD12uGRE6JFlEjWIVWttiTsxdDonI2iJNwnGcqnC/qvDlxvRKZCEA7mTfJTfCdlz
 xAlk2Ykxki4pJJTLeMaRgevs9F32SpIxx696iTiJ7ZaGSRZLKONvS3Qr305xkT7x6U6XawxdLnO
 btwQZChJYL7LHWEMm33y8ikcFht2l8D+040gL4ZgOLR1Ng7h1X4fu7cDJHyIgUyLPIyR+hylLtm
 dfzlor8NmfLftsdiN0tmO+gTyZlvygQFLNwgwI4Ov3dOT2EJCIhEnh8ElASyFUXUOMOOl/+v2+x
 sn7zqZOvt3Eri6KjoWsGo2WIfjqXVYaZZH5SyE/q6/JvliPq89s92/ovGk9fzqcYrz6aHCoS7mD
 vVVF7eObMlBeGzgigSCEK8cZ70DGki0MS8H21y9LxfV43g5SSB+LH6YDIcbDp0fuWTn+M1uVBfG
 qgVL1kRl+56vBvKCcbFSrZqhIFh84L+jcYjL3NKw==
X-Received: by 2002:a05:600c:1552:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-499dc822d91mr141040935e9.13.1787819912972; 
 Thu, 27 Aug 2026 01:38:32 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b49610170sm82761085e9.6.2026.08.27.01.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 01:38:32 -0700 (PDT)
Date: Thu, 27 Aug 2026 10:38:30 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: francesco.dolcini@toradex.com, sbabic@nabladev.com, uboot-imx@nxp.com,
 trini@konsulko.com, franz.schnyder@toradex.com,
 stefan.eichenberger@toradex.com, emanuele.ghidoli@toradex.com,
 sjg@chromium.org, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1] toradex: {aquila, smarc, verdin}-imx95: add
 board_fix_fdt
Message-ID: <ao_3hjKdBccr434g@eichest-laptop>
References: <20260821070958.6997-1-eichest@gmail.com>
 <CAOMZO5AY7nkpdyBckixiBTRLK6f1YTL=H14cLnoMLc+Qh5=MvA@mail.gmail.com>
 <ao1IFKQq7Lni4Kx4@eichest-laptop>
 <CAOMZO5Df=ZoziqoYrAB-3rS+P-giWHjYrhKNBeQE6UKi2a+pBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5Df=ZoziqoYrAB-3rS+P-giWHjYrhKNBeQE6UKi2a+pBA@mail.gmail.com>
X-Mailman-Approved-At: Thu, 27 Aug 2026 12:54:43 +0000
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

Hi Fabio,

On Wed, Aug 26, 2026 at 11:33:56AM -0300, Fabio Estevam wrote:
> Hi Stefan,
> 
> On Tue, Aug 25, 2026 at 4:45 AM Stefan Eichenberger <eichest@gmail.com> wrote:
> 
> > We discussed this internally and decided to implement it in the same way
> > as NXP does in board/nxp/imx95_frdm/imx95_frdm.c, but I'm not sure why
> > it was necessary to put it in the board file. Perhaps because it can
> > only be done in board_fix_fdt, which might be overwritten in the board
> > file anyway? If we were to do this for the entire architecture, we would
> > need to define a weak board_fix_fdt, which could be overwritten, if I
> > understand correctly.
> 
> It seems we should handle this similarly to
> arch/arm/mach-imx/imx8m/soc.c, where peripherals are disabled
> according to the SoC fuses.
> 
> Since this is a property of the SoC rather than a particular board, I
> would prefer to implement the fuse-based fixup once in the common
> i.MX95 SoC code instead of adding the same board_fix_fdt()
> implementation to every i.MX95 board.
> 
> This would also avoid requiring each new i.MX95 board to duplicate
> this code in the future.
> 
> Could you please move this to the common i. MX95 SoC code? If there is
> a technical reason we can't do that, we can revisit the per-board
> approach.

I think the only way I can implement it is by using board_fix_fdt. For
the iMX8M, the Linux device tree peripherals are disabled based on the
fuses. This has already been implemented for the iMX95
(ft_system_setup). However, board_fix_fdt disables the peripherals in
the device tree for U-Boot proper. I can't find a machine-specific
function. Am I missing something?

Should board_fix_fdt be defined in an arch based file? Wouldn't that be
incorrect, given that it is called 'board_...'?

Regards,
Stefan
