Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3B6C61DCB
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 12:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA76980E34;
	Fri, 28 Aug 2026 12:22:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t6ZGmNzZ61DO; Fri, 28 Aug 2026 12:22:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787919772;
	bh=qYGGru6Q6MC2vSiLpOrFrKNT/xMCqRAhi22Au8+TSuk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lEVSpli++H/VFEPW6XLmg7VhhYLoMjhhqrkKTO5SS+p8bTMaJQOStCxhdN3p4UKPg
	 lNpQapvJFqMCnFyC7/Q/Vfw05ZFYcixy08dqKzA2F0Xi9fof99L8LAeXaxAdJWVI3A
	 hFf9IhEccmKiou6jx0nZuWk4CgZywsdrjHmM7se4ciKmBRxCCEgv+5I3vmcX/BRnzB
	 C8APCvkEz6dPMKsBdij8aghiHh+m2TEm2q417PVuh15WG+AH0FdH33OjrTAwsFPhqS
	 +Teu+kvu5BBnhN6Sg8OBflpORfjHSRn98ibBUH8hKddbXuZE31Hu4WyTLQtW+0j98H
	 GZ06SS7R3/bdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E155480E52;
	Fri, 28 Aug 2026 12:22:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D745C334
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 12:22:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C914440762
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 12:22:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Fmz0pDIveq5 for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 12:22:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=YMeqWIvZ
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 23C1A4075C
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 12:22:47 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c25420fe973so162336566b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 05:22:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787919765; cv=none;
 d=google.com; s=arc-20260327;
 b=g46hTuy1MPP0XxxfHjPaPkSvMYxkd+naZ2lKIN/XU/aG650nidMFgmwEc2ncr5AIGU
 /TF2LZGH5whm1e/wFbcpGJMEdf4g8FayOsr/cUYESswOkAhymKWWLFPtzLJWxsN72h7Y
 UiyD+IlllwYT/ErtOknXIzfSGMcgIYWBrAUgXdXNe8QgE2UMXHkizqU8f0ZipHtD1rYX
 CnHX3hX4IvXzqBaRYElqkHvIShx85wDKJ4gcc7ylkRKLE3bgRXMVnTcnGPsxeuTZCtTw
 JfOnHYP/4UM5ee9qbcV0mhdx8R9UXEhDME2/ZU9hacCaVdd2pq6/PJruccYshVVzUMQY
 Jj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qYGGru6Q6MC2vSiLpOrFrKNT/xMCqRAhi22Au8+TSuk=;
 fh=W5ufc5128iPdz6U/yL9G/KPbU406LNOTGgTtj4pdRx4=;
 b=Avc24LYT9cbtdjXRaD/ZAElGF76mpGN+sNq/6zVJFudEikstb+hlQanLLH6E8XQCOn
 Y8ww+b4syVVNczCHFIu+1wFwfaFNnm3rJvr3OhVyV0jIHIAvbNCCl04su1ds7lLBbHiq
 Qzpmqh2FPuP/C8NAplUaHLF1yKqJY4qGH3+niNK93ACIK/MjntiCy/dxGjK9WNGmrnNW
 X0b+s1M7G+ajuFli4CND9R8Kjek81DEGe/uieDc+Lfe6ZpcNComgyiw3cPAJUoj+PcHt
 /H01UCIbQnDPfdeCol+yewdMexLP2GBUmSwlg/EKjY4TGuFe/cVcZNxE9ea5u051nutB
 lZeQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787919765; x=1788524565;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qYGGru6Q6MC2vSiLpOrFrKNT/xMCqRAhi22Au8+TSuk=;
 b=YMeqWIvZyj2MTy68z31XSUa3UKIYWaipb+ASYFnZm/CraKE1nsr9a6mpRw5zWFMGYE
 wiIaAD8X2dHpz/6NKpsTsqqQK0AgE3TAg3DwBrQY9l/83GhWRynFNF6InYgSU7KgWCYb
 gBAjagFhECgzJPomRK605chG74jb5MTuzLR7rPFpuqDtx3l8nGN/olqYOETJ1NO2IokH
 cR7IcLDNSJ60vyNFZPBq2N8C1GkUQTQE8tp+WcaEjkQKWIjo7kHjF1+l4Pz7E47eZf4Q
 8kjm9FW1bkYeLqyLKlv9x/jn5o107DOJifhSBjOdlADF/iowtprklm8QoykL2cGC3q2h
 DWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787919765; x=1788524565;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qYGGru6Q6MC2vSiLpOrFrKNT/xMCqRAhi22Au8+TSuk=;
 b=dttyozRFOR59ieOiZMg0AamoPGQFRinq750IypswAtCEvP85j8CY0L41Vv0+f16CZ0
 IFndxuyw+QzBALlQPidZmIY7bTeItN+ffOdn/XbbvVkES90ajRiIHPUfQTaE8D23tLr2
 jvEa1uK7R2w/nNrLGhNrYLlOdc74n5yRzIyOTRXZ70leb6VJI+9N1YhKcB0cUnSbvAbf
 OllUewDtJHffxN253tP3jYdsNlJjUaKOB4SslBbhuoHBGV/Tl1DXSY1urKRvBOEmKb5P
 10TpiIoGLnn8C49bqnfVrcN4VfUz/sJ42iG4hvmXn+iLMefQOmv1cIpw0ovp4v0x71ia
 uSSA==
X-Gm-Message-State: AFuF++nNKd71M+MnAWwvroeMj/7EvnMxfsv6IEmIPkcQktUSpAqEzAP1
 AtNNui8q2Rl2KU4upNDpRim8mfy2qCGDgr4LE007H7ygyvLm9a5CtQjxHc10B0fvy+UoMgQqNVP
 9c+oB/F0nO47/Mx1ouO+Xafj+2iP7LWP4fSVqZGctKA==
X-Gm-Gg: AR+sD11bJp4n7lLjlo3q7Ktt3xzJLSUKk7dGhAIBvLms4fftu6b8BXjAjIYtS5aL2C4
 CzdKPKazAWPugxeCc+j3qahOsMwAbLQzyhbwXeSSxiP1A9hR8O6S8hnAp42l4t0YlKRCbXxazIp
 WwaIwC7noSeznATsu6p/ZBqBWTmyKgjDTs62Gj/zQpzyVh+dknu/AEzuOizlTxzOs6HaTEKhXvt
 zXAY81csipuxPgMqF48RWEjNVHtxZLluEF5ffXYiV09p84b6knm/eGQscbPd5Hw00bVj2NbXWsM
 INJhbc4ilGt31v1fIn1FEQRo6tf4dQFgCyJIzPSfQcHH8PgKHrOoWP/iG/pzSzFm79LcTbt8S81
 M5VORoWo6sMLyz/AoseEGroOH7Mh4I4lVuOxr+PSMqiiGN0eOha/gTCr2Zw4SyVdB
X-Received: by 2002:a17:906:730e:b0:c25:254:292e with SMTP id
 a640c23a62f3a-c25567a9274mr471406166b.0.1787919765346; Fri, 28 Aug 2026
 05:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
 <20260826-add-genio-510-and-genio-700-hdmi-v2-11-68ebb1bf17df@baylibre.com>
 <f7af7e3a-f721-48a3-92e9-2fb48c735a3d@baylibre.com>
In-Reply-To: <f7af7e3a-f721-48a3-92e9-2fb48c735a3d@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 28 Aug 2026 14:22:36 +0200
X-Gm-Features: AcwNN1X2LeQk7mo0df_joGeOqBL8ZFA6MfvlxJd3v5bZH-D65GrlZOL4FwxCKPM
Message-ID: <CAEHHSvajfMbFeJXqGOBOAFBZ7xv00ykt8QgW4BWKKDGdbZt7LA@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] video: mediatek: add new hdmi driver
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Le mer. 26 ao=C3=BBt 2026 =C3=A0 19:11, David Lechner <dlechner@baylibre.co=
m> a =C3=A9crit :
>
> On 8/26/26 8:09 AM, Julien Stephan wrote:
> > Add a UCLASS_VIDEO driver for the HDMI TX v2 IP found on the MT8188.
> >
> > On probe, the driver waits for a plugged and powered display, reads
> > its EDID through the DDC bus to select the preferred mode, configures
> > the HDMI controller and PHY accordingly, and then programs all the
> > components of the vdosys1 pipeline (MDP RDMA, padding, VPP merge,
> > ETHDR mixer, mutex, DPI1) to scan out the framebuffer. The
> > framebuffer lives in a dedicated reserved-memory region referenced by
> > the "memory-region" property of the hdmi node.
> >
> > Signed-off-by: Pavlo Yadvychuk <pyadvychuk@baylibre.com>
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
...
> > +
> > +#define DEEPCOLOR_MODE_10BIT                 BIT(8)
> > +#define DEEPCOLOR_MODE_12BIT                 GENMASK(9, 8)
> > +#define DEEPCOLOR_MODE_16BIT                 GENMASK(10, 8)
> > +#define DEEPCOLOR_MODE_8BIT                  (0)
>
> These are confusing and don't quite match linux. Should be a field with
> GENMASK(9, 8) and values 0, 1, 2, 3.

Hi David,

Right. These defines are actually wrong. I'll use the header from
upstream kernel verbatim, this will fix this issue and some other name
that do not match kernel, with one exception see below.
By the way, deep color is just dead code, only 8 bit is used right
now, so I'll drop the c code.

>
> > +#define DEEPCOLOR_MODE_MASKBIT                       GENMASK(10, 8)
> > +#define DEEPCOLOR_PAT_EN                     BIT(12)
> > +#define DEEP_COLOR_ADD                               BIT(4)
> > +
> > +#define HDMI2_OFF                            (0)
> > +#define HDMI2_ON                             BIT(2)
> > +
> > +#define HDMITX_SW_HPD                                BIT(29)
> > +#define HDMITX_SW_RSTB                               BIT(31)
> > +
> > +#define HDMI_MODE_DVI                                (0)
> > +#define HDMI_MODE_HDMI                               BIT(3)
> > +
> > +#define HDMI_YUV420_MODE                     BIT(10)
> > +
> > +#define HPD_DDC_STATUS                               0xC60
> > +#define PORD_PIN_STA                         BIT(5)
> > +#define HPD_PIN_STA                          BIT(4)
> > +
> > +#define NULL_PKT_EN                          BIT(2)
> > +#define NULL_PKT_VSYNC_HIGH_EN                       BIT(3)
> > +
> > +#define OUTPUT_FORMAT_DEMUX_420_ENABLE               BIT(10)
> > +
> > +#define REG_VMUTE_EN                         BIT(16)
> > +
> > +#define SCR_OFF                                      0
> > +#define SCR_ON                                       BIT(4)
> > +
> > +#define SPD_DIS                                      0
> > +#define SPD_DIS_WR                           0
> > +#define SPD_EN                                       BIT(1)
> > +#define SPD_EN_WR                            BIT(17)
> > +#define SPD_RPT_DIS                          0
> > +#define SPD_RPT_EN                           BIT(1)
> > +
> > +#define TOP_CFG00                            0x000
> > +#define TOP_CFG01                            0x004
> > +#define TOP_INFO_EN                          0x01C
> > +#define TOP_INFO_RPT                         0x020
> > +#define TOP_AVI_HEADER                               0x024
> > +#define TOP_AVI_PKT00                                0x028
> > +#define TOP_AVI_PKT01                                0x02C
> > +#define TOP_AVI_PKT02                                0x030
> > +#define TOP_AVI_PKT03                                0x034
> > +#define TOP_AVI_PKT04                                0x038
> > +#define TOP_AVI_PKT05                                0x03C
> > +#define TOP_INT_MASK00                               0x1B0
> > +#define TOP_INT_MASK01                               0x1B4
>
> These MASK names don't match Linux.

fixed by using verbatim header

>
> > +#define TOP_MISC_CTLR                                0x1A4
> > +#define TOP_SPDIF_HEADER                     0x054
> > +#define TOP_SPDIF_PKT00                              0x058
> > +#define TOP_SPDIF_PKT01                              0x05C
> > +#define TOP_SPDIF_PKT02                              0x060
> > +#define TOP_SPDIF_PKT03                              0x064
> > +#define TOP_SPDIF_PKT04                              0x068
> > +#define TOP_SPDIF_PKT05                              0x06C
> > +#define TOP_SPDIF_PKT06                              0x070
> > +#define TOP_SPDIF_PKT07                              0x074
> > +#define TOP_VMUTE_CFG1                               0x1C8
> > +
> > +#define VID_DOWNSAMPLE_CONFIG                        0x8F0
>
> This doesn't match upstream Linux (but does match downstream). We should
> confirm which is correct.

According to the datasheet, correct value is 0x8f0. Upstream driver is
wrong. Confirmed with MediaTek.
Here is the patch sent upstream to fix it in the kernel
https://lore.kernel.org/all/20260828-mtk-hdmi-v2-fix-register-offset-v1-1-1=
18ad5d7ebe3@baylibre.com/

>
> > +#define VID_OUT_FORMAT                               0x8FC
> > +
> > +#define ABIST_ENABLE                         BIT(31)
> > +
> > +#define HDCP_TOP_CTRL                                0xC00
> > +#define HDMI_CONFIG                          0xEA0
> > +
...
