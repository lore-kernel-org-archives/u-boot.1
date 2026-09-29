Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3711ECA5FAC
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 20:33:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB87180EDD;
	Tue, 29 Sep 2026 20:33:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VF9a0EDP1lKs; Tue, 29 Sep 2026 20:33:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 68D7F810BE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790713985;
	b=KR2xxVKCveHgSMyBzHqrCsJ9qNjUjbJ0U3ru9RDAeCDHCNugfHKNohwODxMFt1HDBlU0
	 g+FduWQhM0LT9pw1xg9N6lCfF/v6X3Qxkz9z9TMpZbvTo62kPSkzrFHb30MjQ58FwY7Gp
	 7JEQygMc9gwGhDHKSXtQ8lcUV6yamonOLL4Od7fwzfMESqkwfeCJTc8+t3eI1DGnza1st
	 lIdjgrOeCzdmXNt2Pe5bHsWlNsupHOauGohpDpv0yXAu1RjJsouDMFwOR/Q5UBTRDpNho
	 /RLoma5Au4x/p4g25i+h8hEXptlhGH8+v6aEANiOci7EjGkhI2Zp3tlI2tACfAWW3QA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790713985;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EOedGc35j8bEUxH0A8OQa+MvTFpRhHUTva0UCDSpYVI=;
	b=TfVUibyTH3d2GNGcqU+PEThRIr35FnXaf/0OCjgpTiDkM63vdLFNEZcC6BhxQPJxyU+g
	 yoLzs/YJi5xGPpuKqWshiiBNIRCW+K8Wi71dUwXtGznnuOiE1O8J+RtlVUssCrTK4rQky
	 KQxj72q0/iuVLRQuL7E8zznZadExmpZ7YnaehfZU9FyCmj/P7IzV2RLL+igks3qnN5WNi
	 a2Z4itzD9rYhxZ4vxV9afm0Eny7or3/dFx2pMoB8XEdPL3tBV1HNyH8Vy9oT/Qi0LLLB3
	 qCCSLhNNoKmCRXCBvUdni8jOLg59l3WN7fbzz4lUpzB+vcOof/ZhnD+AFCQb1JZMccg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=brivo.com;
	dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256 header.s=google header.b="n0/3gcxg";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790713985;
	bh=EOedGc35j8bEUxH0A8OQa+MvTFpRhHUTva0UCDSpYVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B8H9ueGV6uZKuqr+klg/7p+nSRrcSujXj5OI1QblKpuoK28T4i0EUhnqyiscGxmmb
	 VEaw2ovc4ZBibLgnecs6HU63FmGoRZr+i2qz/+NlkWAs4TRgh80rYHvdJX/Y7vIj9w
	 nD/ra0er7bqpj1CUjWXxtgtLf6h5XsKdmAMj640x/EE7u04RduTJQgVeTp7VB118A5
	 9hterE85YBkQCoYSUHGJaxwQigZS8ju8y0a7o9gsgaYHUm3G5IwQmClFSxnbvQocEk
	 dw4VFg4FGpH/WECQPD6LnOKa6KrXuikyg3+nRR8B2PiCzyiPoQsQJ+u9EMTuGCMR3c
	 dHwZNE4rg4bEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68D7F810BE;
	Tue, 29 Sep 2026 20:33:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DA39532F
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C001780CEE
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RW7bSvCtHmuS for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 18:07:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 12A8080C7B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:34::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790705254;
 b=n/haWIdl+foUMbkyOBXi4jpx02GaMFIFcHalqY75F8w0esAqF3cp8Cr838jPKt3HVD5z
 mOvqLjgnm8xSOt4yq0FFPTctN3yUr89Cmn8kJMEXEW3+z0TNhOg2HknajH1N+/9VA3H2e
 VwN+CDd6P2b+n5f1KwVKy27FFILUrjbGceFo+eafg3DIV3Oc1em6k4XjDLVijrP130R0c
 wNX9OzlCuWGLDKTjC6O9easN0qS8z839oalSi0nKji79oiRyFawTKTxcpfgX/7zwG68Tv
 df542CogleWuFjmtNFw2l45ueCxOppseyXrOQKv0O3yljt0Lf/cvQa5ykREUU/FDWPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790705254;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=EOedGc35j8bEUxH0A8OQa+MvTFpRhHUTva0UCDSpYVI=;
 b=aFjQp+sgN89TycCm1o4CYaLyKC0lYayqopuYpgviMQlBU6/aFXyuAWK+euL7Aplw/Fr0
 KGa3gybwB3Ia/H+EbInepBttoj8qJQ/znCfoS14YdvU7Peu20/l+pKQin8uCLGWI6vQKn
 ProhgQ+7XkXl7VLqM6UXjDLyLrtvXx62fFohmHqhr9lTjOzobetGqSJP0ijhSi44SqFlX
 flG8szHsvQKeWPvYkSnpj+5lgZjzuJ3iQG4EpK5nloBL23ZYZpmfO7mq7kAcjwn+o/aUD
 HMc7qvkRTkX9ZA914ZcJe36OVkG3wf1AmuRpw1OViHGk2LeXsrzATpsgb1HVmZpqCtQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b="n0/3gcxg"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:34::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:34::11; helo=mail-qk2-x11.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=n0/3gcxg
Received: from mail-qk2-x11.google.com (mail-qk2-x11.google.com
 [IPv6:2607:f8b0:4864:34::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 12A8080C7B
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:32 +0000 (UTC)
Received: by mail-qk2-x11.google.com with SMTP id
 af79cd13be357-93a2a8c29c4so387857785a.3
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1790705251; x=1791310051;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EOedGc35j8bEUxH0A8OQa+MvTFpRhHUTva0UCDSpYVI=;
 b=n0/3gcxgkDNud+poz/UFJT3B/n/0Fmn/IQd2I0il5SlltaJ55NSNpGEwuLyEYGWhBZ
 O7C+hmzIpj18qw9T86d9x49BqaGbOGVtLgD+10a9I+A6idknhjenlTtw9K87NRQReC9C
 Vtp8TzYH0Z6sSii/D37dbmoHkCiHngq6oPqa2A3FgBH3Ry28HYxwTQXh0B+hisvRcWNc
 32Mr68BI71Sm/qH5ax4mcSe5wby5uW5VXQdtxXM3QYwg29+BJ/YukpTEiF4RM3zfoq29
 7QIyOI7+v/zmSr1XWMOYodePMKX3gJ1RjggdfxrLls+UtK7jX09tLXgjXgaymp1NSvkA
 UF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790705251; x=1791310051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EOedGc35j8bEUxH0A8OQa+MvTFpRhHUTva0UCDSpYVI=;
 b=Fg6CeoPMua+txlIK1/oY1rjx5t/t7a26aCtuG62qNZhIMgLb3cSYd54+TVPD2Z+bSi
 YpHCP6xy+k+Ph9rYUcfFet3q/W9m/EMJe+ys6+4iHjUZxHVo0QGtXygNH0VvEGH/UMYm
 ZYL1EPq76RoQGmnpZa2dizKclf0PiW7D3dB1s1dtjkp4QYsjtZ54vjFSzG8KpzHOjq+J
 fkCOyEDa/PXJEBoRUUCQGN1Cs0XArPRtc2yHeb6qhBtA5X36yj+9UZoOQTovHkOoh5Sp
 uDUyp9IU75afQBZH+EjIPlFllF9aPHoupj2QxfWGtJV++jmFDN1jv36oXrdqTCugOqDl
 tJIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxeqJaPrBcDpMp+vT4/IQ1QVTK8q4B7F5VN5/iBQ8uyMRAzk8cAgTJ2KBPkoP3s9zT/7Fb1QbY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mnr1acV2mmD7r3BGQBvOc5RKNoJZPhZKng+XfjOab4zlxM2U+6
 JyWtatmgDsIWmrmtS5OEst0eh6zxiBynhshLqMhqPXCzEM7ZJJETiSGXiqmFR5K4mo+9d4uP8Wu
 3vrFjOU+aeyP8KMwBYBoKNXvTJk/6ACWWHYd90P5wzozlLHey7hS7gsfTOJLrt6o=
X-Gm-Gg: AYBFou3WitrSnfuuUOjt/YUd9p2wvUgUIKSaq1fIzTVvqD14r1K0HRJqgiKEdppdKi4
 zFxUp7nyLfLACucb0ciX7GuO8D+dRJa2RGmvxnc+Lj/BXiWxbSuM/h1EzQ3zzfR51rRcgZiOmZ1
 N1tuwolzK4/ZaSEZd3okyzmCj2CHt/ikuRxwlZfvI54tjbgPXa3lFyCoe/jRKgV4JWVKIYsh2YC
 sy3W5Cy2aD+KnQ4r/TcJulQJXRVfm0IHqqJFPu2q5OjxNxlQzhRH1yJJDtQnvZAG67C4i4Mh7KF
 vslmGhIGnKrtYvuRizxsqz7wTXEVUSYRcwdGlzA8r8E8OMtKTSZnuThBF391RxN4LCTb5ohrHu4
 pDfVb066voD0WSewVWeDfg0YhxUITaqmX8GXyC8szqMeGkBPu7Fb9P/YkwoliuFbNwbYxKp0zEw
 nQCx+BdPzOBxiialTPuFXbgvcHmbqIOoyHsh3og+/9oBG04Y6KxCyH6BJw9MD4Fync
X-Received: by 2002:a05:620a:8389:b0:939:ab43:77a1 with SMTP id
 af79cd13be357-93c9f53260bmr69486485a.6.1790705251009; 
 Tue, 29 Sep 2026 11:07:31 -0700 (PDT)
Received: from strozzi ([71.163.254.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c9f462b0esm28802785a.9.2026.09.29.11.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 11:07:30 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sanderson@brivo.com>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 8/9] clk: meson: Add s4 clock driver
Date: Tue, 29 Sep 2026 14:06:30 -0400
Message-ID: <20260929180721.3440839-9-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929180721.3440839-1-sanderson@brivo.com>
References: <20260929180721.3440839-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 20:32:39 +0000
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

Add a clock driver to support for the "s4" series of SoCs (S805X2 and
S905Y4). I've added most of the clocks necessary at boot, although a few
of the unused parents (VID_PLL, RTC) have been omitted. I also left out
the parents of the MPLL clocks, as they have a custom divider. MPLL2 is
enabled by the Ethernet driver but is never actually selected so it's OK
to stub out the parent.

=> clk dump
 Rate               Usecnt      Name
------------------------------------------
 24000000             0        |-- xtal-clk

meson-clk-s4 clock-controller@0:
clock-controller@0:
----------------------------------------------------------------------
            clk           frequency              parent          state
----------------------------------------------------------------------
   sysclk_b_sel           498000000           fclk_div4            N/A
   sysclk_b_div           166000000        sysclk_b_sel            N/A
       sysclk_b           166000000        sysclk_b_div        enabled
   sysclk_a_sel            24000000                xtal            N/A
   sysclk_a_div            24000000        sysclk_a_sel            N/A
       sysclk_a            24000000        sysclk_a_div        enabled
            sys           166000000            sysclk_b            N/A
  sd_emmc_c_sel            24000000                xtal            N/A
  sd_emmc_c_div            24000000       sd_emmc_c_sel            N/A
      sd_emmc_c            24000000       sd_emmc_c_div        enabled
  sd_emmc_a_sel            24000000                xtal            N/A
  sd_emmc_a_div            24000000       sd_emmc_a_sel            N/A
      sd_emmc_a            24000000       sd_emmc_a_div        enabled
  sd_emmc_b_sel            24000000                xtal            N/A
  sd_emmc_b_div            24000000       sd_emmc_b_sel            N/A
      sd_emmc_b            24000000       sd_emmc_b_div        enabled
      pwm_a_sel            24000000                xtal            N/A
      pwm_a_div            24000000           pwm_a_sel            N/A
          pwm_a            24000000           pwm_a_div       disabled
      pwm_b_sel            24000000                xtal            N/A
      pwm_b_div            24000000           pwm_b_sel            N/A
          pwm_b            24000000           pwm_b_div       disabled
      pwm_c_sel            24000000                xtal            N/A
      pwm_c_div            24000000           pwm_c_sel            N/A
          pwm_c            24000000           pwm_c_div       disabled
      pwm_d_sel            24000000                xtal            N/A
      pwm_d_div            24000000           pwm_d_sel            N/A
          pwm_d            24000000           pwm_d_div       disabled
      pwm_e_sel            24000000                xtal            N/A
      pwm_e_div            24000000           pwm_e_sel            N/A
          pwm_e            24000000           pwm_e_div       disabled
      pwm_f_sel            24000000                xtal            N/A
      pwm_f_div            24000000           pwm_f_sel            N/A
          pwm_f            24000000           pwm_f_div       disabled
      pwm_g_sel            24000000                xtal            N/A
      pwm_g_div            24000000           pwm_g_sel            N/A
          pwm_g            24000000           pwm_g_div       disabled
      pwm_h_sel            24000000                xtal            N/A
      pwm_h_div            24000000           pwm_h_sel            N/A
          pwm_h            24000000           pwm_h_div        enabled
      pwm_i_sel            24000000                xtal            N/A
      pwm_i_div            24000000           pwm_i_sel            N/A
          pwm_i            24000000           pwm_i_div       disabled
      pwm_j_sel            24000000                xtal            N/A
      pwm_j_div            24000000           pwm_j_sel            N/A
          pwm_j            24000000           pwm_j_div        enabled
     saradc_sel            24000000                xtal            N/A
     saradc_div              150000          saradc_sel            N/A
         saradc              150000          saradc_div       disabled
         ethphy           166000000                 sys        enabled
       sdemmc_a           166000000                 sys        enabled
       sdemmc_b           166000000                 sys        enabled
           nand           166000000                 sys        enabled
            eth           166000000                 sys        enabled
         uart_a           166000000                 sys        enabled
         uart_b           166000000                 sys        enabled
         uart_c           166000000                 sys        enabled
         uart_d           166000000                 sys        enabled
         uart_e           166000000                 sys        enabled
            usb           166000000                 sys        enabled
        i2c_m_a           166000000                 sys        enabled
        i2c_m_b           166000000                 sys        enabled
        i2c_m_c           166000000                 sys        enabled
        i2c_m_d           166000000                 sys        enabled
        i2c_m_e           166000000                 sys        enabled
    usb1_to_ddr           166000000                 sys        enabled
        sar_adc           166000000                 sys        enabled
         pwm_ab           166000000                 sys        enabled
         pwm_cd           166000000                 sys        enabled
         pwm_ef           166000000                 sys        enabled
         pwm_gh           166000000                 sys        enabled
         pwm_ij           166000000                 sys        enabled
           xtal            24000000             unknown            N/A
      fclk_div2           996000000             unknown            N/A
    fclk_div2p5           796800000             unknown            N/A
      fclk_div3           664000000             unknown            N/A
      fclk_div4           498000000             unknown            N/A
      fclk_div5           398400000             unknown            N/A
      fclk_div7           284571428             unknown            N/A
       hifi_pll          1176000000             unknown            N/A
        gp0_pll             unknown             unknown            N/A
          mpll0             unknown             unknown            N/A
          mpll1             unknown             unknown            N/A
          mpll2             unknown             unknown            N/A
          mpll3             unknown             unknown            N/A
       hdmi_pll             unknown             unknown            N/A

meson-clk-s4 clock-controller@8000:
clock-controller@8000:
----------------------------------------------------------------------
            clk           frequency              parent          state
----------------------------------------------------------------------
  fixed_pll_dco          3984000000                xtal            N/A
      fixed_pll          1992000000       fixed_pll_dco            N/A
  fclk_div2_div           996000000           fixed_pll            N/A
      fclk_div2           996000000       fclk_div2_div        enabled
  fclk_div3_div           664000000           fixed_pll            N/A
      fclk_div3           664000000       fclk_div3_div        enabled
  fclk_div4_div           498000000           fixed_pll            N/A
      fclk_div4           498000000       fclk_div4_div        enabled
  fclk_div5_div           398400000           fixed_pll            N/A
      fclk_div5           398400000       fclk_div5_div        enabled
  fclk_div7_div           284571428           fixed_pll            N/A
      fclk_div7           284571428       fclk_div7_div        enabled
fclk_div2p5_div           796800000           fixed_pll            N/A
    fclk_div2p5           796800000     fclk_div2p5_div        enabled
    gp0_pll_dco             unknown                xtal            N/A
        gp0_pll             unknown         gp0_pll_dco            N/A
   hifi_pll_dco          4704000000                xtal            N/A
       hifi_pll          1176000000        hifi_pll_dco            N/A
   hdmi_pll_dco             unknown                xtal            N/A
    hdmi_pll_od             unknown        hdmi_pll_dco            N/A
       hdmi_pll             unknown         hdmi_pll_od            N/A
   mpll_50m_div            49800000       fixed_pll_dco            N/A
       mpll_50m            49800000        mpll_50m_div            N/A
          mpll0             unknown             unknown       disabled
          mpll1             unknown             unknown       disabled
          mpll2             unknown             unknown        enabled
          mpll3             unknown             unknown       disabled
           xtal            24000000             unknown            N/A

Signed-off-by: Sean Anderson <sanderson@brivo.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---

Changes in v2:
- Add ADC clocks

 drivers/clk/meson/Kconfig  |   8 +
 drivers/clk/meson/Makefile |   1 +
 drivers/clk/meson/s4.c     | 601 +++++++++++++++++++++++++++++++++++++
 3 files changed, 610 insertions(+)
 create mode 100644 drivers/clk/meson/s4.c

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index ee33c611400..abdc6a70e25 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -30,6 +30,14 @@ config CLK_MESON_A1
 	  Enable clock support for the Amlogic A1 SoC family, such as
 	  the A113L
 
+config CLK_MESON_S4
+	bool "Enable clock support for Amlogic S4"
+	depends on CLK && ARCH_MESON
+	default MESON_S4
+	help
+	  Enable clock support for the Amlogic S4 SoC family, such as
+	  the S905Y4/S905W2
+
 config CLK_MESON_MSR
 	bool "Enable clock measure driver for Amlogic SoCs"
 	depends on CLK && ARCH_MESON
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 3d1dfcdb640..705591ed4a9 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -10,4 +10,5 @@ obj-$(CONFIG_CLK_MESON_AXG) += axg-ao.o
 obj-$(CONFIG_CLK_MESON_G12A) += g12a.o
 obj-$(CONFIG_CLK_MESON_G12A) += g12a-ao.o
 obj-$(CONFIG_CLK_MESON_A1) += a1.o
+obj-$(CONFIG_CLK_MESON_S4) += s4.o
 obj-$(CONFIG_CLK_MESON_MSR) += clk-measure.o
diff --git a/drivers/clk/meson/s4.c b/drivers/clk/meson/s4.c
new file mode 100644
index 00000000000..307778db3a0
--- /dev/null
+++ b/drivers/clk/meson/s4.c
@@ -0,0 +1,601 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) Brivo Systems LLC 2026
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <regmap.h>
+#include <dt-bindings/clock/amlogic,s4-pll-clkc.h>
+#include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
+#include "clk_meson.h"
+
+/*
+ * This driver supports both PLL and peripherals clock sources.
+ * Following operations are supported:
+ * - calculating clock frequency on a limited tree
+ * - reading muxes and dividers
+ * - enabling/disabling gates without propagation
+ * - reparenting without rate propagation, only on muxes
+ * - setting rates with limited reparenting, only on dividers with mux parent
+ */
+
+#define RTC_BY_OSCIN_CTRL0                 0x008
+#define RTC_BY_OSCIN_CTRL1                 0x00c
+#define RTC_CTRL                           0x010
+#define SYS_CLK_CTRL0                      0x040
+#define SYS_CLK_EN0_REG0                   0x044
+#define SYS_CLK_EN0_REG1                   0x048
+#define SYS_CLK_EN0_REG2                   0x04c
+#define SYS_CLK_EN0_REG3                   0x050
+#define CECA_CTRL0                         0x088
+#define CECA_CTRL1                         0x08c
+#define CECB_CTRL0                         0x090
+#define CECB_CTRL1                         0x094
+#define SC_CLK_CTRL                        0x098
+#define CLK12_24_CTRL                      0x0a8
+#define VID_CLK_CTRL                       0x0c0
+#define VID_CLK_CTRL2                      0x0c4
+#define VID_CLK_DIV                        0x0c8
+#define VIID_CLK_DIV                       0x0cc
+#define VIID_CLK_CTRL                      0x0d0
+#define HDMI_CLK_CTRL                      0x0e0
+#define VID_PLL_CLK_DIV                    0x0e4
+#define VPU_CLK_CTRL                       0x0e8
+#define VPU_CLKB_CTRL                      0x0ec
+#define VPU_CLKC_CTRL                      0x0f0
+#define VID_LOCK_CLK_CTRL                  0x0f4
+#define VDIN_MEAS_CLK_CTRL                 0x0f8
+#define VAPBCLK_CTRL                       0x0fc
+#define HDCP22_CTRL                        0x100
+#define CDAC_CLK_CTRL                      0x108
+#define VDEC_CLK_CTRL                      0x140
+#define VDEC2_CLK_CTRL                     0x144
+#define VDEC3_CLK_CTRL                     0x148
+#define VDEC4_CLK_CTRL                     0x14c
+#define TS_CLK_CTRL                        0x158
+#define MALI_CLK_CTRL                      0x15c
+#define NAND_CLK_CTRL                      0x168
+#define SD_EMMC_CLK_CTRL                   0x16c
+#define SPICC_CLK_CTRL                     0x174
+#define GEN_CLK_CTRL                       0x178
+#define SAR_CLK_CTRL                       0x17c
+#define PWM_CLK_AB_CTRL                    0x180
+#define PWM_CLK_CD_CTRL                    0x184
+#define PWM_CLK_EF_CTRL                    0x188
+#define PWM_CLK_GH_CTRL                    0x18c
+#define PWM_CLK_IJ_CTRL                    0x190
+#define DEMOD_CLK_CTRL                     0x200
+
+#define FIXPLL_CTRL0                       0x040
+#define FIXPLL_CTRL1                       0x044
+#define FIXPLL_CTRL3                       0x04c
+#define GP0PLL_CTRL0                       0x080
+#define GP0PLL_CTRL1                       0x084
+#define GP0PLL_CTRL2                       0x088
+#define GP0PLL_CTRL3                       0x08c
+#define GP0PLL_CTRL4                       0x090
+#define GP0PLL_CTRL5                       0x094
+#define GP0PLL_CTRL6                       0x098
+#define HIFIPLL_CTRL0                      0x100
+#define HIFIPLL_CTRL1                      0x104
+#define HIFIPLL_CTRL2                      0x108
+#define HIFIPLL_CTRL3                      0x10c
+#define HIFIPLL_CTRL4                      0x110
+#define HIFIPLL_CTRL5                      0x114
+#define HIFIPLL_CTRL6                      0x118
+#define MPLL_CTRL0                         0x180
+#define MPLL_CTRL1                         0x184
+#define MPLL_CTRL2                         0x188
+#define MPLL_CTRL3                         0x18c
+#define MPLL_CTRL4                         0x190
+#define MPLL_CTRL5                         0x194
+#define MPLL_CTRL6                         0x198
+#define MPLL_CTRL7                         0x19c
+#define MPLL_CTRL8                         0x1a0
+#define HDMIPLL_CTRL0                      0x1c0
+
+/* External clock IDs. Those should not overlap with regular IDs */
+enum {
+	EXTERNAL_XTAL = CLKID_ADC_EXTCLK_IN + 1,
+	EXTERNAL_FCLK_DIV2,
+	EXTERNAL_FCLK_DIV2P5,
+	EXTERNAL_FCLK_DIV3,
+	EXTERNAL_FCLK_DIV4,
+	EXTERNAL_FCLK_DIV5,
+	EXTERNAL_FCLK_DIV7,
+	EXTERNAL_HIFI_PLL,
+	EXTERNAL_GP0_PLL,
+	EXTERNAL_MPLL0,
+	EXTERNAL_MPLL1,
+	EXTERNAL_MPLL2,
+	EXTERNAL_MPLL3,
+	EXTERNAL_HDMI_PLL,
+
+	EXTERNAL_PLL_XTAL = CLKID_MPLL3 + 1,
+};
+
+/* S4 peripherals clocks */
+static const struct meson_clk_info *meson_clocks[] = {
+	[CLKID_SYS_CLK_B_SEL] = CLK_MUX("sysclk_b_sel", SYS_CLK_CTRL0, 26, 3, {
+		EXTERNAL_XTAL,
+		EXTERNAL_FCLK_DIV2,
+		EXTERNAL_FCLK_DIV3,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV5,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV7,
+		-ENOENT,
+	}),
+	[CLKID_SYS_CLK_B_DIV] = CLK_DIV("sysclk_b_div", SYS_CLK_CTRL0, 16, 10,
+		CLKID_SYS_CLK_B_SEL
+	),
+	[CLKID_SYS_CLK_B] = CLK_GATE("sysclk_b", SYS_CLK_CTRL0, 29,
+		CLKID_SYS_CLK_B_DIV
+	),
+	[CLKID_SYS_CLK_A_SEL] = CLK_MUX("sysclk_a_sel", SYS_CLK_CTRL0, 10, 3, {
+		EXTERNAL_XTAL,
+		EXTERNAL_FCLK_DIV2,
+		EXTERNAL_FCLK_DIV3,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV5,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV7,
+		-ENOENT,
+	}),
+	[CLKID_SYS_CLK_A_DIV] = CLK_DIV("sysclk_a_div", SYS_CLK_CTRL0, 0, 10,
+		CLKID_SYS_CLK_A_SEL
+	),
+	[CLKID_SYS_CLK_A] = CLK_GATE("sysclk_a", SYS_CLK_CTRL0, 13,
+		CLKID_SYS_CLK_A_DIV
+	),
+	[CLKID_SYS] = CLK_MUX("sys", SYS_CLK_CTRL0, 31, 1, {
+		CLKID_SYS_CLK_A,
+		CLKID_SYS_CLK_B,
+	}),
+
+	[CLKID_SD_EMMC_C_CLK_SEL] = CLK_MUX("sd_emmc_c_sel", NAND_CLK_CTRL, 9, 3, {
+		EXTERNAL_XTAL,
+		EXTERNAL_FCLK_DIV2,
+		EXTERNAL_FCLK_DIV3,
+		EXTERNAL_HIFI_PLL,
+		EXTERNAL_FCLK_DIV2P5,
+		EXTERNAL_MPLL2,
+		EXTERNAL_MPLL3,
+		EXTERNAL_GP0_PLL,
+	}),
+	[CLKID_SD_EMMC_C_CLK_DIV] = CLK_DIV("sd_emmc_c_div", NAND_CLK_CTRL, 0, 7,
+		CLKID_SD_EMMC_C_CLK_SEL
+	),
+	[CLKID_SD_EMMC_C] = CLK_GATE("sd_emmc_c", NAND_CLK_CTRL, 7,
+		CLKID_SD_EMMC_C_CLK_DIV
+	),
+
+	[CLKID_SD_EMMC_A_CLK_SEL] = CLK_MUX("sd_emmc_a_sel", SD_EMMC_CLK_CTRL, 9, 3, {
+		EXTERNAL_XTAL,
+		EXTERNAL_FCLK_DIV2,
+		EXTERNAL_FCLK_DIV3,
+		EXTERNAL_HIFI_PLL,
+		EXTERNAL_FCLK_DIV2P5,
+		EXTERNAL_MPLL2,
+		EXTERNAL_MPLL3,
+		EXTERNAL_GP0_PLL,
+	}),
+	[CLKID_SD_EMMC_A_CLK_DIV] = CLK_DIV("sd_emmc_a_div", SD_EMMC_CLK_CTRL, 0, 7,
+		CLKID_SD_EMMC_A_CLK_SEL
+	),
+	[CLKID_SD_EMMC_A] = CLK_GATE("sd_emmc_a", SD_EMMC_CLK_CTRL, 7,
+		CLKID_SD_EMMC_A_CLK_DIV
+	),
+
+	[CLKID_SD_EMMC_B_CLK_SEL] = CLK_MUX("sd_emmc_b_sel", SD_EMMC_CLK_CTRL, 25, 3, {
+		EXTERNAL_XTAL,
+		EXTERNAL_FCLK_DIV2,
+		EXTERNAL_FCLK_DIV3,
+		EXTERNAL_HIFI_PLL,
+		EXTERNAL_FCLK_DIV2P5,
+		EXTERNAL_MPLL2,
+		EXTERNAL_MPLL3,
+		EXTERNAL_GP0_PLL,
+	}),
+	[CLKID_SD_EMMC_B_CLK_DIV] = CLK_DIV("sd_emmc_b_div", SD_EMMC_CLK_CTRL, 16, 7,
+		CLKID_SD_EMMC_B_CLK_SEL
+	),
+	[CLKID_SD_EMMC_B] = CLK_GATE("sd_emmc_b", SD_EMMC_CLK_CTRL, 23,
+		CLKID_SD_EMMC_B_CLK_DIV
+	),
+
+	[CLKID_PWM_A_SEL] = CLK_MUX("pwm_a_sel", PWM_CLK_AB_CTRL, 9, 2, {
+		EXTERNAL_XTAL,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV3,
+	}),
+	[CLKID_PWM_A_DIV] = CLK_DIV("pwm_a_div", PWM_CLK_AB_CTRL, 0, 8,
+		CLKID_PWM_A_SEL
+	),
+	[CLKID_PWM_A] = CLK_GATE("pwm_a", PWM_CLK_AB_CTRL, 8,
+		CLKID_PWM_A_DIV
+	),
+
+	[CLKID_PWM_B_SEL] = CLK_MUX("pwm_b_sel", PWM_CLK_AB_CTRL, 25, 2, {
+		EXTERNAL_XTAL,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV3,
+	}),
+	[CLKID_PWM_B_DIV] = CLK_DIV("pwm_b_div", PWM_CLK_AB_CTRL, 16, 8,
+		CLKID_PWM_B_SEL
+	),
+	[CLKID_PWM_B] = CLK_GATE("pwm_b", PWM_CLK_AB_CTRL, 24,
+		CLKID_PWM_B_DIV
+	),
+
+	[CLKID_PWM_C_SEL] = CLK_MUX("pwm_c_sel", PWM_CLK_CD_CTRL, 9, 2, {
+		EXTERNAL_XTAL,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV3,
+	}),
+	[CLKID_PWM_C_DIV] = CLK_DIV("pwm_c_div", PWM_CLK_CD_CTRL, 0, 8,
+		CLKID_PWM_C_SEL
+	),
+	[CLKID_PWM_C] = CLK_GATE("pwm_c", PWM_CLK_CD_CTRL, 8,
+		CLKID_PWM_C_DIV
+	),
+
+	[CLKID_PWM_D_SEL] = CLK_MUX("pwm_d_sel", PWM_CLK_CD_CTRL, 25, 2, {
+		EXTERNAL_XTAL,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV3,
+	}),
+	[CLKID_PWM_D_DIV] = CLK_DIV("pwm_d_div", PWM_CLK_CD_CTRL, 16, 8,
+		CLKID_PWM_D_SEL
+	),
+	[CLKID_PWM_D] = CLK_GATE("pwm_d", PWM_CLK_CD_CTRL, 24,
+		CLKID_PWM_D_DIV
+	),
+
+	[CLKID_PWM_E_SEL] = CLK_MUX("pwm_e_sel", PWM_CLK_EF_CTRL, 9, 2, {
+		EXTERNAL_XTAL,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV3,
+	}),
+	[CLKID_PWM_E_DIV] = CLK_DIV("pwm_e_div", PWM_CLK_EF_CTRL, 0, 8,
+		CLKID_PWM_E_SEL
+	),
+	[CLKID_PWM_E] = CLK_GATE("pwm_e", PWM_CLK_EF_CTRL, 8,
+		CLKID_PWM_E_DIV
+	),
+
+	[CLKID_PWM_F_SEL] = CLK_MUX("pwm_f_sel", PWM_CLK_EF_CTRL, 25, 2, {
+		EXTERNAL_XTAL,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV3,
+	}),
+	[CLKID_PWM_F_DIV] = CLK_DIV("pwm_f_div", PWM_CLK_EF_CTRL, 16, 8,
+		CLKID_PWM_F_SEL
+	),
+	[CLKID_PWM_F] = CLK_GATE("pwm_f", PWM_CLK_EF_CTRL, 24,
+		CLKID_PWM_F_DIV
+	),
+
+	[CLKID_PWM_G_SEL] = CLK_MUX("pwm_g_sel", PWM_CLK_GH_CTRL, 9, 2, {
+		EXTERNAL_XTAL,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV3,
+	}),
+	[CLKID_PWM_G_DIV] = CLK_DIV("pwm_g_div", PWM_CLK_GH_CTRL, 0, 8,
+		CLKID_PWM_G_SEL
+	),
+	[CLKID_PWM_G] = CLK_GATE("pwm_g", PWM_CLK_GH_CTRL, 8,
+		CLKID_PWM_G_DIV
+	),
+
+	[CLKID_PWM_H_SEL] = CLK_MUX("pwm_h_sel", PWM_CLK_GH_CTRL, 25, 2, {
+		EXTERNAL_XTAL,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV3,
+	}),
+	[CLKID_PWM_H_DIV] = CLK_DIV("pwm_h_div", PWM_CLK_GH_CTRL, 16, 8,
+		CLKID_PWM_H_SEL
+	),
+	[CLKID_PWM_H] = CLK_GATE("pwm_h", PWM_CLK_GH_CTRL, 24,
+		CLKID_PWM_H_DIV
+	),
+
+	[CLKID_PWM_I_SEL] = CLK_MUX("pwm_i_sel", PWM_CLK_IJ_CTRL, 9, 2, {
+		EXTERNAL_XTAL,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV3,
+	}),
+	[CLKID_PWM_I_DIV] = CLK_DIV("pwm_i_div", PWM_CLK_IJ_CTRL, 0, 8,
+		CLKID_PWM_I_SEL
+	),
+	[CLKID_PWM_I] = CLK_GATE("pwm_i", PWM_CLK_IJ_CTRL, 8,
+		CLKID_PWM_I_DIV
+	),
+
+	[CLKID_PWM_J_SEL] = CLK_MUX("pwm_j_sel", PWM_CLK_IJ_CTRL, 25, 2, {
+		EXTERNAL_XTAL,
+		-ENOENT,
+		EXTERNAL_FCLK_DIV4,
+		EXTERNAL_FCLK_DIV3,
+	}),
+	[CLKID_PWM_J_DIV] = CLK_DIV("pwm_j_div", PWM_CLK_IJ_CTRL, 16, 8,
+		CLKID_PWM_J_SEL
+	),
+	[CLKID_PWM_J] = CLK_GATE("pwm_j", PWM_CLK_IJ_CTRL, 24,
+		CLKID_PWM_J_DIV
+	),
+
+	[CLKID_SARADC_SEL] = CLK_MUX("saradc_sel", SAR_CLK_CTRL, 9, 2, {
+		EXTERNAL_XTAL,
+		CLKID_SYS,
+	}),
+	[CLKID_SARADC_DIV] = CLK_DIV("saradc_div", SAR_CLK_CTRL, 0, 8,
+		CLKID_SARADC_SEL
+	),
+	[CLKID_SARADC] = CLK_GATE("saradc", SAR_CLK_CTRL, 8,
+		CLKID_SARADC_DIV
+	),
+
+	[CLKID_ETHPHY] = CLK_GATE("ethphy", SYS_CLK_EN0_REG0, 4,
+		CLKID_SYS
+	),
+	[CLKID_SDEMMC_A] = CLK_GATE("sdemmc_a", SYS_CLK_EN0_REG0, 24,
+		CLKID_SYS
+	),
+	[CLKID_SDEMMC_B] = CLK_GATE("sdemmc_b", SYS_CLK_EN0_REG0, 25,
+		CLKID_SYS
+	),
+	[CLKID_NAND] = CLK_GATE("nand", SYS_CLK_EN0_REG0, 26,
+		CLKID_SYS
+	),
+
+	[CLKID_ETH] = CLK_GATE("eth", SYS_CLK_EN0_REG1, 3,
+		CLKID_SYS
+	),
+	[CLKID_UART_A] = CLK_GATE("uart_a", SYS_CLK_EN0_REG1, 5,
+		CLKID_SYS
+	),
+	[CLKID_UART_B] = CLK_GATE("uart_b", SYS_CLK_EN0_REG1, 6,
+		CLKID_SYS
+	),
+	[CLKID_UART_C] = CLK_GATE("uart_c", SYS_CLK_EN0_REG1, 7,
+		CLKID_SYS
+	),
+	[CLKID_UART_D] = CLK_GATE("uart_d", SYS_CLK_EN0_REG1, 8,
+		CLKID_SYS
+	),
+	[CLKID_UART_E] = CLK_GATE("uart_e", SYS_CLK_EN0_REG1, 9,
+		CLKID_SYS
+	),
+	[CLKID_USB] = CLK_GATE("usb", SYS_CLK_EN0_REG1, 26,
+		CLKID_SYS
+	),
+	[CLKID_I2C_M_A] = CLK_GATE("i2c_m_a", SYS_CLK_EN0_REG1, 30,
+		CLKID_SYS
+	),
+	[CLKID_I2C_M_B] = CLK_GATE("i2c_m_b", SYS_CLK_EN0_REG1, 31,
+		CLKID_SYS
+	),
+
+	[CLKID_I2C_M_C] = CLK_GATE("i2c_m_c", SYS_CLK_EN0_REG2, 0,
+		CLKID_SYS
+	),
+	[CLKID_I2C_M_D] = CLK_GATE("i2c_m_d", SYS_CLK_EN0_REG2, 1,
+		CLKID_SYS
+	),
+	[CLKID_I2C_M_E] = CLK_GATE("i2c_m_e", SYS_CLK_EN0_REG2, 2,
+		CLKID_SYS
+	),
+	[CLKID_USB1_TO_DDR] = CLK_GATE("usb1_to_ddr", SYS_CLK_EN0_REG2, 8,
+		CLKID_SYS
+	),
+	[CLKID_SAR_ADC] = CLK_GATE("sar_adc", SYS_CLK_EN0_REG2, 28,
+		CLKID_SYS
+	),
+
+	[CLKID_PWM_AB] = CLK_GATE("pwm_ab", SYS_CLK_EN0_REG3, 7,
+		CLKID_SYS
+	),
+	[CLKID_PWM_CD] = CLK_GATE("pwm_cd", SYS_CLK_EN0_REG3, 8,
+		CLKID_SYS
+	),
+	[CLKID_PWM_EF] = CLK_GATE("pwm_ef", SYS_CLK_EN0_REG3, 9,
+		CLKID_SYS
+	),
+	[CLKID_PWM_GH] = CLK_GATE("pwm_gh", SYS_CLK_EN0_REG3, 10,
+		CLKID_SYS
+	),
+	[CLKID_PWM_IJ] = CLK_GATE("pwm_ij", SYS_CLK_EN0_REG3, 11,
+		CLKID_SYS
+	),
+
+	[EXTERNAL_XTAL] = CLK_EXTERNAL("xtal"),
+	[EXTERNAL_FCLK_DIV2] = CLK_EXTERNAL("fclk_div2"),
+	[EXTERNAL_FCLK_DIV2P5] = CLK_EXTERNAL("fclk_div2p5"),
+	[EXTERNAL_FCLK_DIV3] = CLK_EXTERNAL("fclk_div3"),
+	[EXTERNAL_FCLK_DIV4] = CLK_EXTERNAL("fclk_div4"),
+	[EXTERNAL_FCLK_DIV5] = CLK_EXTERNAL("fclk_div5"),
+	[EXTERNAL_FCLK_DIV7] = CLK_EXTERNAL("fclk_div7"),
+	[EXTERNAL_HIFI_PLL] = CLK_EXTERNAL("hifi_pll"),
+	[EXTERNAL_GP0_PLL] = CLK_EXTERNAL("gp0_pll"),
+	[EXTERNAL_MPLL0] = CLK_EXTERNAL("mpll0"),
+	[EXTERNAL_MPLL1] = CLK_EXTERNAL("mpll1"),
+	[EXTERNAL_MPLL2] = CLK_EXTERNAL("mpll2"),
+	[EXTERNAL_MPLL3] = CLK_EXTERNAL("mpll3"),
+	[EXTERNAL_HDMI_PLL] = CLK_EXTERNAL("hdmi_pll"),
+};
+
+/* S4 PLL clocks */
+static const struct meson_clk_info *meson_pll_clocks[] = {
+	[CLKID_FIXED_PLL_DCO] = CLK_PLL("fixed_pll_dco", EXTERNAL_PLL_XTAL, {
+		{FIXPLL_CTRL0, 0, 8},
+		{FIXPLL_CTRL0, 10, 5},
+	}),
+	[CLKID_GP0_PLL_DCO] = CLK_PLL("gp0_pll_dco", EXTERNAL_PLL_XTAL, {
+		{GP0PLL_CTRL0, 0, 8},
+		{GP0PLL_CTRL0, 10, 5},
+	}),
+	[CLKID_HIFI_PLL_DCO] = CLK_PLL("hifi_pll_dco", EXTERNAL_PLL_XTAL, {
+		{HIFIPLL_CTRL0, 0, 8},
+		{HIFIPLL_CTRL0, 10, 5},
+	}),
+	[CLKID_HDMI_PLL_DCO] = CLK_PLL("hdmi_pll_dco", EXTERNAL_PLL_XTAL, {
+		{HDMIPLL_CTRL0, 0, 8},
+		{HDMIPLL_CTRL0, 10, 5},
+	}),
+
+	[CLKID_FIXED_PLL] = CLK_DIV2("fixed_pll", FIXPLL_CTRL0, 16, 2,
+		CLKID_FIXED_PLL_DCO
+	),
+	[CLKID_FCLK_DIV2_DIV] = CLK_DIV_FIXED("fclk_div2_div", 2,
+		CLKID_FIXED_PLL
+	),
+	[CLKID_FCLK_DIV2P5_DIV] = CLK_DIV_FIXED_FULL("fclk_div2p5_div", 2, 5,
+		CLKID_FIXED_PLL
+	),
+	[CLKID_FCLK_DIV3_DIV] = CLK_DIV_FIXED("fclk_div3_div", 3,
+		CLKID_FIXED_PLL
+	),
+	[CLKID_FCLK_DIV4_DIV] = CLK_DIV_FIXED("fclk_div4_div", 4,
+		CLKID_FIXED_PLL
+	),
+	[CLKID_FCLK_DIV5_DIV] = CLK_DIV_FIXED("fclk_div5_div", 5,
+		CLKID_FIXED_PLL
+	),
+	[CLKID_FCLK_DIV7_DIV] = CLK_DIV_FIXED("fclk_div7_div", 7,
+		CLKID_FIXED_PLL
+	),
+	[CLKID_GP0_PLL] = CLK_DIV2("gp0_pll", GP0PLL_CTRL0, 16, 3,
+		CLKID_GP0_PLL_DCO
+	),
+	[CLKID_HDMI_PLL_OD] = CLK_DIV2("hdmi_pll_od", HDMIPLL_CTRL0, 16, 4,
+		CLKID_HDMI_PLL_DCO
+	),
+	[CLKID_MPLL_50M_DIV] = CLK_DIV_FIXED("mpll_50m_div", 80,
+		CLKID_FIXED_PLL_DCO
+	),
+
+	[CLKID_FCLK_DIV2] = CLK_GATE("fclk_div2", FIXPLL_CTRL1, 24,
+		CLKID_FCLK_DIV2_DIV
+	),
+	[CLKID_FCLK_DIV2P5] = CLK_GATE("fclk_div2p5", FIXPLL_CTRL1, 25,
+		CLKID_FCLK_DIV2P5_DIV
+	),
+	[CLKID_FCLK_DIV3] = CLK_GATE("fclk_div3", FIXPLL_CTRL1, 20,
+		CLKID_FCLK_DIV3_DIV
+	),
+	[CLKID_FCLK_DIV4] = CLK_GATE("fclk_div4", FIXPLL_CTRL1, 21,
+		CLKID_FCLK_DIV4_DIV
+	),
+	[CLKID_FCLK_DIV5] = CLK_GATE("fclk_div5", FIXPLL_CTRL1, 22,
+		CLKID_FCLK_DIV5_DIV
+	),
+	[CLKID_FCLK_DIV7] = CLK_GATE("fclk_div7", FIXPLL_CTRL1, 23,
+		CLKID_FCLK_DIV7_DIV
+	),
+	[CLKID_HIFI_PLL] = CLK_DIV2("hifi_pll", HIFIPLL_CTRL0, 16, 2,
+		CLKID_HIFI_PLL_DCO
+	),
+	[CLKID_HDMI_PLL] = CLK_DIV("hdmi_pll", HDMIPLL_CTRL0, 20, 2,
+		CLKID_HDMI_PLL_OD
+	),
+	[CLKID_MPLL_50M] = CLK_MUX("mpll_50m", FIXPLL_CTRL3, 5, 1, {
+		EXTERNAL_PLL_XTAL,
+		CLKID_MPLL_50M_DIV,
+	}),
+	[CLKID_MPLL0] = CLK_GATE("mpll0", MPLL_CTRL1, 31,
+		-ENOENT
+	),
+	[CLKID_MPLL1] = CLK_GATE("mpll1", MPLL_CTRL3, 31,
+		-ENOENT
+	),
+	[CLKID_MPLL2] = CLK_GATE("mpll2", MPLL_CTRL5, 31,
+		-ENOENT
+	),
+	[CLKID_MPLL3] = CLK_GATE("mpll3", MPLL_CTRL7, 31,
+		-ENOENT
+	),
+
+	[EXTERNAL_PLL_XTAL] = CLK_EXTERNAL("xtal"),
+};
+
+static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
+{
+	switch (clk->id) {
+	case CLKID_SD_EMMC_A_CLK_DIV:
+	case CLKID_SD_EMMC_B_CLK_DIV:
+	case CLKID_SD_EMMC_C_CLK_DIV:
+		return meson_composite_set_rate(clk, rate);
+	case CLKID_SD_EMMC_A:
+	case CLKID_SD_EMMC_B:
+	case CLKID_SD_EMMC_C: {
+		struct clk parent = {
+			.dev = clk->dev,
+			.id = meson_clk_get_parent(clk),
+		};
+
+		return meson_clk_set_rate(&parent, rate);
+	}
+	}
+
+	return -EINVAL;
+}
+
+static int meson_clk_probe(struct udevice *dev)
+{
+	struct meson_clk *priv = dev_get_priv(dev);
+
+	return regmap_init_mem(dev_ofnode(dev), &priv->map);
+}
+
+struct meson_clk_data meson_s4_peripherals_info = {
+	.clocks = meson_clocks,
+	.num_clocks = ARRAY_SIZE(meson_clocks),
+};
+
+struct meson_clk_data meson_s4_pll_info = {
+	.clocks = meson_pll_clocks,
+	.num_clocks = ARRAY_SIZE(meson_pll_clocks),
+};
+
+static const struct udevice_id meson_clk_ids[] = {
+	{
+		.compatible = "amlogic,s4-peripherals-clkc",
+		.data = (ulong)&meson_s4_peripherals_info,
+	},
+	{
+		.compatible = "amlogic,s4-pll-clkc",
+		.data = (ulong)&meson_s4_pll_info,
+	},
+	{ }
+};
+
+static struct clk_ops meson_clk_ops = {
+	.disable	= meson_clk_disable,
+	.enable		= meson_clk_enable,
+	.get_rate	= meson_clk_get_rate,
+	.set_rate	= meson_clk_set_rate,
+	.set_parent	= meson_clk_set_parent,
+#if IS_ENABLED(CONFIG_CMD_CLK)
+	.dump		= meson_clk_dump,
+#endif
+};
+
+U_BOOT_DRIVER(meson_clk_s4) = {
+	.name		= "meson-clk-s4",
+	.id		= UCLASS_CLK,
+	.of_match	= meson_clk_ids,
+	.priv_auto	= sizeof(struct meson_clk),
+	.ops		= &meson_clk_ops,
+	.probe		= meson_clk_probe,
+};
-- 
2.53.0

