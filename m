Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CC6C54F51
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 21:56:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F257D81458;
	Tue, 28 Jul 2026 21:56:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m5kwxAm10leL; Tue, 28 Jul 2026 21:56:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 262F481455
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785275810;
	bh=xOnGV0A+q/wf3R8vwQc1PJDO4KiHvHnIe8IAzFS/oVc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a4IEo2fbzU2rtiRJwvDlUaY5IKqvH6AkVx0sHZ3ESesCGwzxRPNj2nQm8uPazb4RK
	 rd5Lmv8X7dLiuNcBWvMMUK+Uxw6pcmwWk4ufoUMJcxfAEJd10KXzpcEOEfWMejjNxm
	 usa+mEB02y+RG+EINXmJG0m9vdQFT4z496QXvuaYYz4C9eEA7Qgkv6ENOEi99iTUyE
	 m3tiDAyuI5iuXjjaCF/SAPZsHtGwzbyMr8/3ckKGjOpxnTvz2W1dnxLf+6LiU/uwlr
	 C6MAJJkJAjNeBCyY/7mF1GyDWt02uo97dUfyQL9lj2tJJwMTVNMXTERghEeMVQC024
	 +5MFVEJXrg5pQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 262F481455;
	Tue, 28 Jul 2026 21:56:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 55C5D2E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3BC4140057
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G4dnl7QAVhLN for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 21:56:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 851A240051
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 851A240051
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 851A240051
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:44 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e6b554044fso343504a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785275803; x=1785880603;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xOnGV0A+q/wf3R8vwQc1PJDO4KiHvHnIe8IAzFS/oVc=;
 b=rwwjnKmkkuJfHnA9ecrFk2aUI9QkWnkjoAnW8u2lKxyQ298Kj2oLOs6H71549a9+Pu
 VmkIZRwpCBiB9dcu6bLHvn9XmZ/gDtICKgLKNkFR+LKNPx34aicvrg0/XlBsUCiAm+yX
 m2CqxJXogibuD7pIe6SiCXla6eR57/PruemeWzSjhat0pC334CsgKC++IBT9peuA4wxp
 KRw7Aw95NfXEYSMeZ4GuZ/+R6fsh22NvYtC5d8V5wH4vIxQAD2fsv2P6FQv9/B5WS3Ye
 Q9+d9PIX/iXMzhYO75eBw45H1fSx231Rsq/DhMRMOBiKUmlQy+mCWXp2RMEbZDAAE/ug
 vImQ==
X-Gm-Message-State: AOJu0YzkmWdNRTUbpgaJwFp4/SfNKMf8QGv4Bxww/8FQohgvrXNF52Jf
 djyyX8qUUuYbwGweRYOJ8Dltv/W+qJkW5+cFYNKNRoSbxmfSXKH9RNouloK09p+xxzQ=
X-Gm-Gg: AR+sD1041XfZhFrVRMImRJFM2Wos/nzKMn72mzaKM9kaB9H6oK1oti8dC+PodvvdDOd
 2gxncLAchD2Lv9SiXwOTtALcnUIxAFNH2y09aaM07MjYXFYYF7UtyWsL+rCCq1bwT114vEMI0sL
 l/voNJygbWSLzz41BDuqZNrbS4IMlJXyUiBSfIeWbfc2AssjNarrw/VoMnifujm06Af5UthN/KM
 Tf3Ux16JA98xZou/w1RRaFFjk4XtUgPA9LGdTEU7Cy+u9N0v7RqRftF704PnuD0WC+04ExMysYM
 hw0ZBx8WZXnDsyzKFB2E8R9KGyxlHxna8RF7DcLBPxFuRJfJP4kaflskXRxpKIkzMo3b6sPUmTV
 2fizUknvWru63yDBkazSpiYjSIji0egiiQ9u5zrdfiWphjnNHwhXDpNMnso0h4DEuvdyC80cEQy
 hKaD+tTahtw2MKaH4kd2FV4X9EJSFfqzBZe/90YTIYlHzavDj78TAEqlcbbc2sfwsWJ1KtLuKy0
 FEgoNfJqizSeA3coSUUGanBN2mDAPqBz2hJ+siqOyPmZyP09Uv5iFLZFA3kDa+SFytkiwdVHuHB
 dnaRgFwm
X-Received: by 2002:a05:6830:8292:b0:7e9:d67e:b4e with SMTP id
 46e09a7af769-7efff0bacefmr2782199a34.17.1785275803450; 
 Tue, 28 Jul 2026 14:56:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d2d8112sm780106a34.0.2026.07.28.14.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:56:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Jordi Trepat Mur <yordy1902@gmail.com>
Cc: sjg@chromium.org, vigneshr@ti.com, nm@ti.com, anshuld@ti.com
In-Reply-To: <20260625174121.3633162-1-yordy1902@gmail.com>
References: <20260614103232.3586246-1-yordy1902@gmail.com>
 <20260625174121.3633162-1-yordy1902@gmail.com>
Subject: Re: [PATCH v2] pinctrl: single: parse gpio-range as a raw array
 (O(N^2) -> O(N))
Message-Id: <178527580263.1742553.11634930266680051980.b4-ty@konsulko.com>
Date: Tue, 28 Jul 2026 15:56:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785275803; x=1785880603;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xOnGV0A+q/wf3R8vwQc1PJDO4KiHvHnIe8IAzFS/oVc=;
 b=gJJNfzaMlbxRe6tyvgoVDgyZ4avvSLn8cgtiOcMTlGvUHqgjoRt895RisTxw2vz5gy
 kcA/lVkEjQhC1TVDi4pLXV7bLKMVyX4rwgCv1AVyECMRb/UANjiScvoAwebjSc/xUNed
 jVHQQLr7pfjtJilIOFXrNq2TXq0s/VklXqNhk=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=gJJNfzaM
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, 25 Jun 2026 19:41:21 +0200, Jordi Trepat Mur wrote:

> single_add_gpio_func() calls ofnode_parse_phandle_with_args() once per
> gpio-range entry. With a flat device tree, every call re-iterates the
> property from index 0 and, because cellname is set, performs an
> fdt_node_offset_by_phandle() (a full-FDT scan) at every step. The total
> cost is therefore quadratic in the number of entries and proportional to
> the size of the device tree.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] pinctrl: single: parse gpio-range as a raw array (O(N^2) -> O(N))
      commit: 11f5a60ba75af27c8a63e1e0e5d3f6cddaca1c7a
-- 
Tom


