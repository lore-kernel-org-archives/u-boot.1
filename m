Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE095C61DC2
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 12:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5706E405B1;
	Tue, 25 Aug 2026 12:45:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Ckh9dI9ZfJK; Tue, 25 Aug 2026 12:44:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787661899;
	bh=sRVvZ4wDpC40kk3NiobMyh6tQ3qd4Kq+HEMW3nFoPyQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mmxjVzN9CMorvdHD4NH9rRo2hnm7I5KTp+JuUv7yeji48PtXSko9DP/kqWqrYEgLd
	 p6xnsAu1n1DTBBO2APrAsQM2szGCEEkZDM1eaE8V1O4kl99gU7pDXPjahGaNPHzxvi
	 epDlk5XdfYavoaiPz8++ZJBl2W2ips23wEebIXwj+141sqMBUPA/+PBqbJjBwfeP80
	 RcCrohIV814lnN5jpYdCH6uUDAZ8oCgp6Um5hQTjQGR8T7BYseUzGd5y47zmYUOskq
	 LZDzHtb4I1hpbH3rvnYdiarU6BIuLET38OKrrmYurMlmKTU0mubEVut7dWjt8VGfR6
	 bsQxEy48/FZqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95F83405A2;
	Tue, 25 Aug 2026 12:44:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EC9222FD
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:44:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE82C405A2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:44:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dvehNToqylOu for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 12:44:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=VXYkqiGG
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DBC0040592
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:44:57 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c1c26d7e951so708911466b.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 05:44:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787661895; cv=none;
 d=google.com; s=arc-20260327;
 b=O7s/qc/vt1dd/vTAO++lIZt5yUfoh2SZD8LCAnJbRs93RW3yL0c+ZslLUxgFr+jjt9
 azFeKDV+9qIYwj3gfksx/dsiPyJsIyDQYpTpvlEsDMuU5mrSD7tv0TgNM27OS16SL5N9
 Ic7V8OAzrdUVBx9Yv4MplxgPAuu81oDNtDPAoRDOs6HT5JLINXJDpVQSXhbIlIBEwa8A
 4ASvPxZQcL2sHGyl1jj2RwcRJlHwCysyAnppEVdiSBGF4ksGqQkEaa8U0g6aYfkQxSMm
 31Zy3Y3c8Va2WRr0uFAieodShUaN12hzwsayRFWHED+PluGNf5SInbYpcxmzk3RkHu8N
 Wr9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sRVvZ4wDpC40kk3NiobMyh6tQ3qd4Kq+HEMW3nFoPyQ=;
 fh=erIv6YLiqg7F6Q2HwGSEAX/RzGfEay9y1qiL1SEoMrU=;
 b=ZMOhLp/j4LncYxi6RO97y5otqpGm2iYtP1+JbP/eWEiw9ybcceOWOOVS+1acn/AIEG
 GbtHCYImc2hlxx6J1bDlskt3XoYNzdBYuZRIlnsnlP24HMd/OUCYAsPRG8r6JeKQrgQd
 /seS9a2rLchCtuPFXpnGq7H0vRUh8UdvWjgWNTqPbKgck2TBCoV58w3wpnnhn7yHSYtG
 7Kk5Rlbq1kW+tgyNy03LXKnBhytkgNKThuKEoTh0p+MbQCoQsA5RX0kFabaDjipOBTww
 pFIdP+nm4/xHgSFwZfSe6CTNyK6VRwL6YMvepwQLuPnbZcLr1eErVGlzefSD9Ra0Kdgm
 TL/w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787661895; x=1788266695;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sRVvZ4wDpC40kk3NiobMyh6tQ3qd4Kq+HEMW3nFoPyQ=;
 b=VXYkqiGG1GFnbezU1H+eiAb6NkPsf65NywQHd2qCc03lik6wSUzGhIc1aXE+xVPFVE
 LgFhuMxlcQbT8CB9IVR/TQRc/vpMWf7UCHHbwx9Yr/+I0zh3JP4mMHfzH8+A/VfQZERg
 wT6+Ki39tbx8TaF5YRW3a7YWvH2vvEjbdin2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787661895; x=1788266695;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sRVvZ4wDpC40kk3NiobMyh6tQ3qd4Kq+HEMW3nFoPyQ=;
 b=NQM9Fsebnq7TsMc80jOQrv04N56CBZLleg/ADbwsyXDX4P/y0L70c0LH6PlzM54abp
 7EryaFlNDR1/e+5zPDS65xh2J80oN8ORM/fpQFrH4+699/A+TswrAs9WdExEWIdbZNui
 +0Aipse/ORmjwY6nIuIikol6ZYcydQdtK8qzF1fp/3U5jBAaHTcXyARe+dykvLPT1XbS
 N7EiqRQY7Hb6lNE7UzE6fjAnzsb77jcaiWYS7ZvTyu5LbyyumhwDHa6lnWth2hEdfRrI
 ecWV4M7g9ZGYDdjGm63RGimRfG5tIh/8ObiJ5p01DpfVChnKspnmUtzI1Ob+f+HTOkLX
 5EgQ==
X-Gm-Message-State: AFuF++kPs92+G7KgD7+JIMILZ3TR0GlhKs+6jrhjTpqIb0P1OxpPXbuM
 3UmbdR6bcFGFK3XGxpK6jL2w+T+BNLg3l0eIgYQJkHb6c2IFfShGi2/I/ib2RF5R8WEzP7uGYEw
 tFZ5KwoOO2I/TcJYG5Z9oqIj3ZdGPjqO5QyboinqgTl0MFq+EG1vvmKWf
X-Gm-Gg: AR+sD11VxGbCBZmu6z7Bu2XLhLupX6CBT/SK+i0BCH4AExbRAZI1/Leu5UTIxxJCrsT
 +MeX89+BitNinTw+Rr9AXMZPp56HOtyMY0cSBUK/kyTCpIMBO9amlDbJ5jh8xmBLTF7fuirJpqN
 ZtL3lBNWBQ8TC0ZjEQ7w2T4pcooaTcauCmfTtqFPgM5XqAyhRxbCNQjXFRbnvwQg9q6Xxw1+h52
 yGruzRJHzYMKYu9r/TgmmnVpQVW245SUNFVab3MBZebqfftiTFme9pzDXijUzn+EOORTR48kfWt
 GNcOQFfSBED3qDOXXx4YrTZjepTtcI3UIi9xUyW7qFA=
X-Received: by 2002:a17:907:7b93:b0:c20:5213:56f1 with SMTP id
 a640c23a62f3a-c246a60348emr3682682566b.13.1787661895119; Tue, 25 Aug 2026
 05:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com>
 <CAFLszTgX08U3GpcvwkvzBinY7X21EC_P2nEZPx3ikVH=vBt_yA@mail.gmail.com>
 <DKX99AW58JTS.8UMKA33XJC4J@baylibre.com>
In-Reply-To: <DKX99AW58JTS.8UMKA33XJC4J@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Aug 2026 06:44:41 -0600
X-Gm-Features: AcwNN1UPsU5mXWPXueNavlBG6kHKp6eIeYGUy07E_B1P3voKh7L_jrCGy_CrmKA
Message-ID: <CAFLszTj9435WLtL2aPorpXjAZW=jS7tJOik+rvsvg44R2EEo=Q@mail.gmail.com>
Subject: Re: [v2,0/5] firmware-owned devicetree for EBBR / SystemReady IR
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Carlo,

On Mon, 24 Aug 2026 at 08:48, Carlo Caione <ccaione@baylibre.com> wrote:
>
> On Sat Aug 15, 2026 at 8:45 PM CEST, Simon Glass wrote:
> > Hi Carlo,
> >
> > On 2026-07-28T13:20:42, Carlo Caione <ccaione@baylibre.com> wrote:
> >
> >> Patch 1 makes an FDT passed to efi_bootmgr_run() outrank a Boot#### FDT,
> >> as an independent behaviour fix. Patch 2 adds the loader, binding,
> >> documentation and shared EFI staging policy. Patches 3 and 4 integrate
> >> the EFI bootmeth and boot manager. Patch 5 adds sandbox coverage.
> > [..]
> >
> >> - 'fw_fdt_part' can pin an A/B partition and 'fw_fdt_config' can select
> >>   an explicit configuration.
> >
> > Just to check - is exposing these as environment variables really the
> > right long-term interface? U-Boot has been moving configuration into
> > the control devicetree, and both of these look like properties that
> > would sit naturally on the u-boot,firmware-fdt-block node, with the
> > env var overriding for A/B slot selection only. What do you think?
>
> Hi Simon,
> Replying only to this point because all the other comments have my ACK.
>
> Agreed regarding fw_fdt_part: it is indeed intended as the runtime A/B
> slot override, while the stable storage location remains described by
> the provider phandle and partition UUID/name in the control devicetree.
>
> Now, fw_fdt_config is slightly different though. We need configuration
> selection to depend on the selected boot target. For example in our
> usecase, the same firmware FIT may provide a base-only configuration
> for a generic distribution and an overlay configuration for a platform
> image. The control devicetree is identical in both cases, so a fixed
> property there cannot express that choice.
>
> Static selection is already covered by compatible best-match and
> the FIT default. I would retain fw_fdt_config only as an explicit
> runtime override above those mechanisms and clarify that role in the
> documentation if that is ok with you.

Yes that seems reasonable to me, thanks for explaining.

Regards,
Simon
