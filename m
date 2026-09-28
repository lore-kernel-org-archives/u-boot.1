Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B6BC9832F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 09:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B48B405EF;
	Mon, 28 Sep 2026 09:17:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pe98pljLcq-h; Mon, 28 Sep 2026 09:17:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7100B4059E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790587064;
	b=CGdJWtOIgK4bvMMVSCcjjf3zJgkC2RSlNzU/rRsLLkoIX7rt6OfGDhDcO8uaoS2AWK8+
	 +N3/WUSwZ+UKRhbfaLT1r6FMBaJYJwbU833VauYUq1OkeWIq7V9MY2Mmpzhy4VfqLHk6z
	 MHbwTuMg8AIqZdbc5TMGPOL6pqyLnrCyRcYuWvFUNdD0QOERRaVmlaEAXEfF3uDIhRD3o
	 kaI+OB3l6hQQhtrc68i7h4g6rrqqJGCud6uKJHaiP4e+h45/m3kdzRQFuATBBI+3cAHlS
	 ymmiFQvTh6a7mZuGs8tUBl5pS3vTY3uzyUsEOzkojUHFMxjh6MVp5243F0S1sYVNyyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790587064;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dfOK8LLYoESSzEjTTVd0UHfBcw4o8Dq5VixTFyajgQo=;
	b=oBkA+9/j0NkmQJuhW2SQrXBygXuiKLpnTXoxCZ4Y6sw5enYiLmNKUoOhCMmaAJwBe0DH
	 QqcHAE4ES8wiIxChFN+sm1WnKGyZR1tQyFd4Atqvb8oUMERnG2Knq/cR/aeMwvTJUAZxM
	 CZcnTvl8Psg0zpPeO0KvNz4QhH9UiPiIN0eTOUObw4EUQwl8MsDxaFgeDlRQZpnfQtVlH
	 fy6qfYJLiIORYneUQPqKRapvOBIo7j6iFx9D92TjRO6uTR78DC3RJS5qB+ucrRa6FGb8B
	 m/fEBVafDxHLzveCWrO0X7Ipu35MpqjQOhywoQaY8GwAMdR7wkfYK3tTgYfFVCo8Yrw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790587064;
	bh=dfOK8LLYoESSzEjTTVd0UHfBcw4o8Dq5VixTFyajgQo=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rjUrl+NVIqXqSvrRnPa/UEODfhHJ4oMCWKFtk5Qh8XeoCXaEEoP0R8biMOq+ugqrr
	 up7MmKXfSKJyhy8EAd7OhLboVt8acyD41Sty/fhUTAJn73/xq/Zn20NLWQ2rU5QZfy
	 Wz3uReA3m6bxS3scWIcu2pw/az1LyIVZocYZuwqNW/Qw9DjFaYLFz2TrUwz2jaUe3Z
	 ecE/RH2MJu13Nij5WRNqRQCiIZ3a3eRHWyb6GYcBNTDS4Hwc8P09S31Xt10cDTkDL9
	 0WyHyU3C77xOU3otIfpuh9Kx2uFl7e5/S9X1rjvctlozFtHjJ1PMxeBknrNcZwe6Ek
	 QKkdSJO5J03gQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7100B4059E;
	Mon, 28 Sep 2026 09:17:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FED772
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 420A640198
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r4E7hFkccIgT for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 09:17:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A6D5340194
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::15"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790587057;
 b=SPJeISPFBO8FUa0aLHjlQe6lO4YvIOMZBpYaW8Q/gPeYsOapIe1pTv2CYwx6z/G6m1t0
 OIDHQdmIeVIzlWxtP+IpEKu1Y1skSt0484i4eZNxhIlX7g+GZ1FaieN946mi4pVXrcQQu
 U/ZGNQ57waJrv+dxXtUi16096s0xRItp2Jj7hPIGHnTRPxsmnYuDsZx1bwwhcKZCa5YEZ
 +N7F+J+gmsP8ds8DMOQDfRafoo6xKO2n9oaafW9HM8J2clcFx3wycFv4UeJ0NPMFZswcW
 PAi9HDzayeE1ye7HOg+/7suLWUJ7SDnWMNsDUofIzlh2hjSdXZ9FuzGNrHCfSdJYiGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790587057;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=dfOK8LLYoESSzEjTTVd0UHfBcw4o8Dq5VixTFyajgQo=;
 b=gWuL8oluBTYUs5gWiZApSow3dfqY3cIIuO6C7iT3r0rt83x6NWUk9dN0nKPr1nRuoM9u
 SUbqUSLG6ucCThEPMuX47XngQn2HbPhDDrbqlLswCyWfXg2tb09gRFiHHQkC5Cjaeeb2i
 p36Hh0uxU+tg0O2iQikR/OSQisnntkuYABDMCuaBwpnP8RggyI7pa4mrzFIp0kPHo9W8B
 0qDa0S4OmOhl4vDBc/cTVrX2u7Bfw5lx/KG0VezL01VHEi3ysoV+5LtYMc8O790K1vabr
 MHIt5hIGDctdHmi0ut38OtryOUGfGp2/36J5auqQAs89q72HUI/fuNPIAt+pMDuKPQA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=URRjbKRI; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::15"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::15; helo=mail-wr2-x15.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=URRjbKRI
Received: from mail-wr2-x15.google.com (mail-wr2-x15.google.com
 [IPv6:2a00:1450:4864:30::15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A6D5340194
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:34 +0000 (UTC)
Received: by mail-wr2-x15.google.com with SMTP id
 ffacd0b85a97d-488780459e2so2771154f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 02:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790587053; x=1791191853;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dfOK8LLYoESSzEjTTVd0UHfBcw4o8Dq5VixTFyajgQo=;
 b=URRjbKRItXbmmKdaN4gwG3jmI56m1Dv/3UBYPauUg3xcKfU3BihxJF7SmQR7g7I0xF
 GjW9BpakWb+UdtcnVBtX6Q7+3iZDyjzccw9CDZyqcATGCNPPl413Emb1XKIdEbPz7/7O
 RBq3ZQaizLLre8zIOQ5wjMapHcmMH4B4EJjm6rHwFCF+3rb09Zsa9ZW77qu33j9Qq0xg
 6nkOZSMKUfEjzGd8c2k+Dle0aHiAeWA7X//+pcz8y1rZuFtvo+FYHmtiaqEwYj2KoI5q
 T6A3T4V2xoJV9lGeAoVSf34EXHsEXKgLxyvJ/gEmfIGWcoAHBcMxnUvwYV+4Lzpea+I0
 OBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790587053; x=1791191853;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dfOK8LLYoESSzEjTTVd0UHfBcw4o8Dq5VixTFyajgQo=;
 b=VUwtyHIB01vgTzmqucfuKBx2I/CjvF6vvPkSTSi6F3LlhCCcJ9QN6hVlgXFsnJyUvM
 ny2JGjz7vOCZ8voyqAXV/01I349+f7f9n3SNudJkBIfB81iVZ3Ub0dlydV9SsfNwIqh0
 Xu2lpuVQTWVHi9pYz8cofViQYQjjsqFbB4i3igHngnOY7LlQUI2kk1M6J8J4+ein6TjY
 Pf35W7AYK4wIZW8tLzg7j5lSxjHBOexAkLb+ua5GiNe3nfvncQLZalX/5mtYQ8m8UppB
 6u/ooRoqvJrGZIIq5XuWG5LXxFdnhaWhn+l81wSHeRW4RMqjpF3w1k2LkFvlx6JjJ/9p
 VhOQ==
X-Gm-Message-State: AFq9FYLxqwYUCBDxOUT5UVGH8UNTGiRk1kCOHQ+s7DJiJ5STnZMj641X
 LN1NFivpok5dpmGdYvwkb3FiNyOQwnZC75Q4Btd2zwp4Rfz7HECUbFc0jzvo8gIPkXaBezVt/XF
 NyLV/dJM=
X-Gm-Gg: AYBFou0COY3bzVwgGoqJitMLnlZ3+VVIhnxgQaUxg5+elyaTl55t2uRsl4Mxac9E13J
 QA9mV0iJQgz9h514l/OyRPg+YMAeAL3hRB/sXsWHGn1VFiTj4yOzCuoqlsA6xCMZzDfJyJNopuB
 Xl//p2Lf8kSnY9yoa6549fKURlKmck0+Dw8S5dKv1uNyaAqGqxi1k4INxTzA0sx+gudxaQ+NGQg
 jyHD9STperK3b4XDjJpiUWD10Pj0b6wah48+kPTbc7+Y+HayVSTsTcTLJ9L8y9vAfF56LO+kPMv
 DNOu+4y+CgoJwiWl0VEgs68GpOebH1Qvv0vt1XfsRUFeIrh8G3NRwbRdehkALmjU0UwaGkq/Ipd
 XCeGi7nDGUorkOBGqJB1DCeAYeN9zLbHiRmN1TWSCnCoXeGTXZ/RpTlBYm01atwdeuTRk+9Jjnn
 v0AOLj34SkVpl+yiIXVE/jEOtQUccQAwsDtpAI1wnx9fUNrRQcvkr1XIVPtUVsV0ToLk552r9nB
 XVyeK1DSnhO5P+I/gqH3LefQNySFL3zgwYZxQl4XEXPJr7u5Xu7dN34B5Ob6jxW7sO2bwIGpOoC
 3cEEu0gHqMOCcp0rGluuDXN5PvTDNg+3HXwZ1xK976m/Bp/bPr/Gq08=
X-Received: by 2002:adf:e195:0:b0:488:8193:4581 with SMTP id
 ffacd0b85a97d-488819346eamr17416570f8f.31.1790587052721; 
 Mon, 28 Sep 2026 02:17:32 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a64ef3asm26404622f8f.30.2026.09.28.02.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 02:17:32 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v7 00/12] mediatek: add HDMI pipeline support for MT8188
 based boards
Date: Mon, 28 Sep 2026 11:19:35 +0200
Message-Id: <20260928-add-genio-510-and-genio-700-hdmi-v7-0-ee4a61a8ac1d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QTU7DMBAF4KtUXmNkj+1x3BX3QCz8M26NaIKSE
 lFVuTtOATVCkcjyjUbfG82VDdQXGth+d2U9jWUoXVuDfdixePTtgXhJNTMQgMIKyX1K/EBt6bi
 Rgvv2N1kh+DGdCo8eIWJoQIrIKvPeUy6ft4rnl+88fIRXiufZnTeOZTh3/eV2wyjnvZ86aP6vG
 yWv82h0SNZkh+Ip+MtbCT09xu7E5sYR7mYDuMGEamJDIciQpU15xVR30215y6iqqRrptDdKBrd
 m6qUJG0xdTRtV0Flg4w2umGZp6g2mqWZKLiWC7CzQiokLE8wGE6sJjhAwgFTk/pjTNH0BFk1uN
 YkCAAA=
X-Change-ID: 20260701-add-genio-510-and-genio-700-hdmi-ca62c6b8210c
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.15.2
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

This series adds HDMI support for MT8188 based boards, such as the Genio
510 and Genio 700 EVKs, in order to display a boot logo over HDMI. It
builds on top of the HDMI PHY driver [1], the DDC (I2C) driver [2], the
clock series [3] and a clock fix [4] already sent earlier.

The drivers here were inspired by the corresponding kernel drivers, but
were largely modified, mainly because U-Boot has no DRM framework and
the goal is only to display a framebuffer. The HDMI driver locates each
pipeline component through the device-tree aliases the SoC dtsi already
provides and programs them directly. The framebuffer is allocated by
the video uclass.

The video pipeline looks like this:

             framebuffer (in DRAM)
                       |
          +------------+------------+
          v                         v
      mdp_rdma4                 mdp_rdma5      two DMA read engines,
     (left half)               (right half)   each fetching one frame half
          |                         |
       padding4                  padding5      (bypass)
          |                         |
          +------------+------------+
                       v
                  vpp merge (merge3)           recombine the two halves
                       |
                       v
                 ethdr mixer (ethdr0)
                       |
                       v
                  hdr back-end                  (bypass)
                       |
                       v
                  vpp merge (merge5)
                       |
                       v
                     dpi1                       timing generator -> HDMI TX
                       |
                       v
      ddc/i2c ---> hdmi tx controller
    (read EDID)        |
                       v
                   hdmi phy
                       |
                       v
              hdmi connector ---> sink

  mutex1  : hardware SOF synchronization across the pipeline
  vdosys1 : routing muxes (SEL_IN/SOUT) and the sizes of the
            clock-domain-crossing wrappers between the blocks above
  larb2/3 : SMI local arbiters gating the RDMAs' access to DRAM

The series adds the HDMI TX controller (UCLASS_VIDEO), a set of shared
display-component helpers and the individual pipeline components (ethdr,
merge, mutex, padding, rdma, dpi1), a minimal SMI local arbiter driver,
and the config that enables the pipeline.

Tested on a Genio 700 EVK: the U-Boot logo shows up on an HDMI display.

[1]: https://patchwork.ozlabs.org/project/uboot/patch/20260717-mt8188-add-hdmi-phy-driver-v1-1-4278457fe2cb@baylibre.com/
[2]: https://patchwork.ozlabs.org/project/uboot/cover/20260717-mt8188-add-ddc-i2c-driver-v1-0-e89ccd173567@baylibre.com/
[3]: https://patchwork.ozlabs.org/project/uboot/patch/20260715-mt8188-add-clk-add-display-related-clocks-v2-1-0aaf7accaeb0@baylibre.com/
[4]: https://patchwork.ozlabs.org/project/uboot/patch/20260728-mt8188-clk-fix-top0-gate-polarity-v1-1-56bc92ba6055@baylibre.com/

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v7:
- rename mtk-smi-larb to mtk-smi to align with kernel. Also update
  config symbol and alilgn description with kernel
- Link to v6: https://patch.msgid.link/20260925-add-genio-510-and-genio-700-hdmi-v6-0-29e626b213e9@baylibre.com

Changes in v6:
- dts: dropped the framebuffer reserved-memory patch; the framebuffer is
  now allocated by the video uclass, sized for the largest mode
- kernel-doc for the exported API and structures
- <linux/bitops.h> where BIT()/GENMASK() are used; MediaTek spelling
- SMI larb: refcount enable/disable
- component helpers: larb lookup moved here from rdma
- ethdr: program MIX_L_SRC_OFFSET(2); enable the mixer last
- merge: read-modify-write of CFG_37
- mutex: Linux names for the SOF and module indices
- rdma: retitled "add mdp rdma component"; datasheet names for the
  downstream-only fields
- dpi: fix inverted HSYNC/VSYNC polarity; clear YUV422_EN/CSC_ENABLE
- hdmi driver: DM_FLAG_PRE_RELOC; set priv->format; yuv420 bypass only
  clears HDMI_YUV420_MODE; document the HDR back-end routing, the VDOSYS1
  power dependency and the 4:3 VICs
- Link to v5: https://patch.msgid.link/20260904-add-genio-510-and-genio-700-hdmi-v5-0-dd9dde2f972e@baylibre.com

Changes in v5:
Across the whole series
- Dropped the dead colorspace/colorimetry handling: only RGB444 8bpc is ever produced, so set_csp_depth/csp, the YUV
cases of the AVI InfoFrame, the YUV420 downsample path and the DPI CSC are gone. That removed the only user of the
include/linux/hdmi.h added in v2, so that patch is dropped too.
- Programmed the resolution- and DRAM-latency-dependent registers the mainline kernel writes and this series skipped;
their reset values only work at the timing they happened to be tested at. Retested on a Genio 700 EVK.
- of_match tables consistently use "{ }".
- Include hygiene: <linux/bitops.h>, <errno.h> and <fdtdec.h> where needed, unused <video.h>/<asm/io.h> dropped, #endif
guards named, redundant "struct udevice;" forward declarations removed.

Per patch
- memory: new preparatory patch sorting drivers/memory/Makefile, so the larb entry lands in an ordered list.
- SMI larb: moved to drivers/memory/mtk-smi-larb.c with its own CONFIG_MTK_SMI_LARB and UCLASS_MEMORY
- component helpers: added mtk_disp_comp_update(), the read-modify-write counterpart of mtk_disp_comp_write().
- ethdr: put the HDR video back-end in bypass like Linux' mtk_ethdr_config() does; "vdo_be" mapped by reg-name.
- merge: mtk_disp_merge_config() reshaped to the kernel's (l_w, r_w, h) and CFG_1/25/27 written unconditionally;
documented that the single-input no-fifo mode is unreachable from this pipeline, hence untested.
- padding: clear all four registers in bypass mode, not only the picture size
- rdma:
  - program MDP_RDMA_GMCIF_CON and clear MDP_RDMA_COMP_CON and FLD_OUTPUT_ARGB
  - reject a stride too wide for FLD_MF_BKGD_WB;
  -print the framebuffer base with "%#lx" (it is a ulong);
  - resolve the larb in UCLASS_MEMORY.
- rdma: kept the datasheet name BGRA8888 over the kernel's RDMA_INPUT_FORMAT_RGBA8888 (same byte order, i.e.
DRM_FORMAT_XRGB8888) and TRANSFORM_0 bit 15 over MDP_RDMA_CON's FLD_OUTPUT_10B (that bit is in neither kernel driver, it
came with the downstream U-Boot code). Both documented in comments.
- dpi: the CSC/matrix path went with the colorspace handling, and MATRIX_SEL_RGB_TO_BT709 with it; mtk_dpi_hw_disable()
is now used, in the HDMI probe unwind; mtk_dpi_mask() replaced by mtk_disp_comp_update(); local types renamed
mtk_dpintf_* -> mtk_dpi_* (this node is mediatek,mt8195-dpi, not the dp-intf variant) and the config parameters const.
- get_unaligned_le24(): moved between the le16 and le32 helpers to keep the file ordered, and split into
__get_unaligned_le24()/get_unaligned_le24() as Linux has it.
- hdmi driver: above 340 MHz, tell the sink to scramble and use the 1/40 bit clock ratio through its SCDC TMDS_Config
(offset 0x20 at I2C 0x54).
- hdmi driver: sink type taken from the EDID (hdmi_monitor) instead of always assuming HDMI, and no InfoFrames sent to a
DVI sink.
- hdmi driver: zero the EDID extension block when reading it fails, so the parser cannot pick a timing out of
uninitialised stack
- hdmi driver: propagate the generic_phy_configure()/_power_on() failures instead of logging and carrying on.
- hdmi driver: clear the GCP AVMUTE, in case an earlier boot stage left the sink muted.
- hdmi driver: the VIC is now looked up in a table keyed on the timing's exact rounded refresh rate; an unknown timing
reports VIC 0 and no aspect ratio rather than a wrong one, and the AVI colorimetry is "No Data" as CTA-861 wants for
RGB. Also set A0 in the AVI InfoFrame, the active format R3..R0 is only valid with it.
- hdmi driver: mtk_hdmi_mode_valid() also rejects interlaced timings, odd widths and pixel clocks outside 25-594 MHz.
The pipeline reads the frame as two halves and feeds the DPI two pixels per clock, and the PHY will not lock outside
that range; rejecting them here lets the EDID parser fall back to the next detailed timing instead of failing.
- hdmi driver: no data islands towards a DVI sink either, the GCP and null packets are gated on hdmi_monitor like the
InfoFrames.
- hdmi driver: dropped the infoframe buffer size checks, which cannot fail, and collapsed the three-way HPD state into
a bool.
- hdmi driver: program the vdosys1 clock-domain-crossing wrapper sizes and the mixer input padding. The alpha half of
the kernel's mtk_mmsys_mixer_in_config() is left alone: the mixer layer runs with MIXER_ALPHA_AEN clear.
- hdmi driver: zero the framebuffer before the RDMAs start and enable the DPI last, so a stale reserved region is never
scanned out; video_post_probe() only clears the framebuffer after probe returns.
- hdmi driver: dev_remap_addr() and a void __iomem * for the register window; extension_flag instead of a raw 0x7e
offset; the 150 us settle delay moved back where the kernel has it, so it does not fire on the disable path; "display is
not connected" demoted to debug; the cached struct display_timing dropped, timing and buffer parameters const, "inline"
dropped from the two static helpers, includes sorted.
- hdmi driver: retitled "video: mediatek: add hdmi driver".
- mtk_hdmi_regs_v2.h is a verbatim copy of the kernel header except VID_DOWNSAMPLE_CONFIG, at 0x8f0 per the MT8390/MT8188 datasheet and not the
0x8d0 Linux uses (a patch was sent to fix this on kernel side)
- dts: the reserved-memory and the hdmi "memory-region" phandle are a single patch now; SPDX (GPL-2.0 OR MIT) ->
(GPL-2.0-only OR MIT), node renamed framebuffer@72000000, 32 MiB size documented.
- configs: drop CONFIG_CMD_I2C, the DDC transfers go through DM_I2C inside the driver; the commit message notes that
CONFIG_VIDEO_LOGO is "default y if !SPLASH_SCREEN", so CONFIG_VIDEO=y already brings it in.
- Link to v4: https://patch.msgid.link/20260902-add-genio-510-and-genio-700-hdmi-v4-0-7c3b4f068a56@baylibre.com

Changes in v4:
- refresh config fragment with savedefconfig: remove CONFIG_VIDEO_LOGO,
  correctly place CONFIG_WATCHDOG_AUTOSTART
  that is enabled by default
- reword commit message on patch 13: remove useless mentions to larb/vdosys1 aliases that were removed in v3
- Link to v3: https://patch.msgid.link/20260901-add-genio-510-and-genio-700-hdmi-v3-0-38194a531b9f@baylibre.com

Changes in v3:
Across the whole series
- Re-based every register definition on the mainline Linux kernel definitions (upstream names, values and
BIT()/GENMASK()/FIELD_PREP()) instead of the downstream U-Boot ones.
- SPDX fixes: GPL-2.0 / GPL-2.0+ -> GPL-2.0-only on all new driver files, Makefile and Kconfig; relicensed
include/linux/hdmi.h to MIT (it's a partial port of Linux' MIT-licensed header) and added the full MIT permission text.
- Bind on the generic mediatek,mt8195-* fallback compatible (shared IP) rather than the SoC-specific mediatek,mt8188-*:
dpi, ethdr, merge, rdma.
- Makefile/Kconfig header cleanup: copyright set to BayLibre and the obj- list sorted alphabetically.

Per patch
- display pipeline component helpers: reworded the commit message (probe and enable sequence).
- ethdr: use the kernel's parameterized MIX_L_SRC_CON(n)/MIX_L_SRC_SIZE(n) macros, drop the unused *_CK_EN defines, add
BACKGROUND_RELAY to the datapath write; keep the downstream-only L2 select bits behind a comment.
- merge: rename registers to the kernel's DISP_REG_MERGE_* / MERGE_EN; keep the downstream-only CFG_30 behind a comment.
- mutex: make the register offsets index-based (DISP_MUTEX_*(id)) and rename the helper to mtk_disp_mutex_config_hdmi()
so a future DSI user can reuse it.
- padding: rename registers to the kernel's PADDING_CONTROL_REG / PADDING_ENABLE / PADDING_PIC_SIZE_REG.
- rdma: use the kernel's FLD_* fields with FIELD_PREP(); take the stride from the framebuffer line_length instead of
recomputing it; error out if the framebuffer base is above 4 GB (the source-base register is 32-bit), add larb configuration.
- dpi: import mtk_dpi_regs.h verbatim from the mainline kernel and adjust the driver to the upstream names (DPI_RET,
DPI_INPUT_2P_EN, DPI_OUTPUT_1T1P_EN); keep the one downstream-only matrix value (MATRIX_SEL_RGB_TO_BT709) locally.
- include/linux/hdmi.h: MIT relicense (see above).
- hdmi driver: move the register defines into a new mtk_hdmi_regs_v2.h imported verbatim from the mainline kernel;
correct VID_DOWNSAMPLE_CONFIG to 0x8f0 per the MT8390 datasheet (mainline has a wrong 0x8d0 — a separate kernel fix was
sent); remove the dead deep-color code path (the driver only ever drives 8 bpc); drop the unused length argument of the
infoframe helpers; check the RDMA config return value; resolve the vdosys1 syscon via ofnode_by_compatible() instead of
a U-Boot-invented alias.
- dts (reserved-memory): drop the unused splashscreen carveout, keep only the framebuffer region; retitle the patch to
"add framebuffer reserved-memory".
- dts (hdmi override): drop the U-Boot-invented vdosys1 alias (resolved by compatible now) and larb2/larb3 aliases
now resolved using iommus and DT directly inside rdma component.
- configs: use CONFIG_VIDEO_LOGO (show the U-Boot logo) instead of CONFIG_SPLASH_SCREEN, since upstream lacks the
plumbing to make the splash actually work — this also keeps CONFIG_EXPO enabled and drops the now-unneeded CMD_BMP /
BMP_24BPP.
- Link to v2: https://patch.msgid.link/20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com

Changes in v2:
- Add a common `get_unaligned_le24()` helper for reading 24-bit little-endian values, ported from kernel
- Add a common `linux/hdmi.h` header with HDMI colorspace and colorimetry enums, based on the corresponding Linux header.
- Refactor the HDMI driver to use the new common HDMI definitions and unaligned access helper.
- Rename the mixer component to ETHDR and configure the ETHDR before the remaining display pipeline components.
- Add the SMI LARB components and configure the VDOSYS1 routing directly from the HDMI driver.
- Switch display component lookup from phandles to DT aliases and add proper error unwinding for component clocks, HDMI PHY power, and clock resources.
- Refactor HDMI register access and InfoFrame handling.
- Improve HDMI mode handling, YUV420 downsampling, TMDS scrambling, deep-color handling, and InfoFrame generation.
- Move framebuffer/splash reserved-memory definitions to the Genio common U-Boot DTSI and add the corresponding HDMI override node for MT8390/Genio EVKs.
- Drop the dedicated MT8188 VDOSYS1 pipeline component and its corresponding DTS node, to avoid having 2 nodes with same reg address.
- Remove the unnecessary `dm_scan_fdt_dev` bind hook from the HDMI driver.
- Link to v1: https://patch.msgid.link/20260728-add-genio-510-and-genio-700-hdmi-v1-0-ac54bd75f960@baylibre.com

To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Pavlo Yadvychuk <pyadvychuk@baylibre.com>
Cc: Macpaul Lin <Macpaul.Lin@mediatek.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Carlo Caione <ccaione@baylibre.com>
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Rasmus Villemoes <ravi@prevas.dk>

---
Julien Stephan (12):
      memory: sort the Makefile alphabetically
      memory: mediatek: add SMI larb driver
      video: mediatek: add display pipeline component helpers
      video: mediatek: add ethdr component
      video: mediatek: add merge component
      video: mediatek: add mutex component
      video: mediatek: add padding component
      video: mediatek: add mdp rdma component
      video: mediatek: add dpi1 component
      asm-generic: unaligned: add get_unaligned_le24()
      video: mediatek: add hdmi driver
      configs: mediatek: mt8188: enable hdmi pipeline

 configs/mt8188.config                     |    4 +
 drivers/memory/Kconfig                    |    9 +
 drivers/memory/Makefile                   |    3 +-
 drivers/memory/mtk-smi.c                  |   89 +++
 drivers/video/Kconfig                     |    1 +
 drivers/video/Makefile                    |    1 +
 drivers/video/mediatek/Kconfig            |   22 +
 drivers/video/mediatek/Makefile           |   15 +
 drivers/video/mediatek/mtk_disp_comp.c    |  123 ++++
 drivers/video/mediatek/mtk_disp_comp.h    |   95 +++
 drivers/video/mediatek/mtk_disp_merge.c   |  154 +++++
 drivers/video/mediatek/mtk_disp_merge.h   |   44 ++
 drivers/video/mediatek/mtk_disp_mutex.c   |   79 +++
 drivers/video/mediatek/mtk_disp_mutex.h   |   21 +
 drivers/video/mediatek/mtk_disp_padding.c |   49 ++
 drivers/video/mediatek/mtk_disp_padding.h |   20 +
 drivers/video/mediatek/mtk_dpi.c          |  372 +++++++++++
 drivers/video/mediatek/mtk_dpi.h          |   34 +
 drivers/video/mediatek/mtk_dpi_regs.h     |  247 +++++++
 drivers/video/mediatek/mtk_ethdr.c        |  106 +++
 drivers/video/mediatek/mtk_ethdr.h        |   37 ++
 drivers/video/mediatek/mtk_hdmi.c         | 1027 +++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_hdmi_regs_v2.h |  263 ++++++++
 drivers/video/mediatek/mtk_mdp_rdma.c     |  185 ++++++
 drivers/video/mediatek/mtk_mdp_rdma.h     |   34 +
 include/asm-generic/unaligned.h           |   10 +
 include/mtk_smi.h                         |   37 ++
 27 files changed, 3080 insertions(+), 1 deletion(-)
---
base-commit: 677a768c91b2baaefdf09633d1fdb5c9f758674f
change-id: 20260701-add-genio-510-and-genio-700-hdmi-ca62c6b8210c

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

