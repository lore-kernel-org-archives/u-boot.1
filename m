Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BA0105F7AE
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8EEA84307;
	Fri, 13 Mar 2026 15:30:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IeOr6Nx0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B524F8430F; Fri, 13 Mar 2026 15:30:02 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE652842FC
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 15:29:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b96e9c59339so338869966b.1
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 07:29:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773412199; cv=none;
 d=google.com; s=arc-20240605;
 b=LVeeJCFDNKVDDIMiYze1gNDW9omqzcyDhOaYArbi8VZ4bkw1Orqt0YyhK0sBYqy2u6
 LIj3UKpUR825Wtwnmd6+3DlaFuPS51l3Xid9SFwpR0FBdoSTmQ8dYNN6BvFqnzItK5Bx
 fzuz8zkeiAxxJvZ24fE1+pW5qKIjaG8kfy/v2RUbsTYqotyjjYoQ8L8I3iaGkljlKTqi
 mDM8Hp5Q32RWPwTJaiI+SfYvHyZ4c7Ua8E5q9oTucpkTFaa4jgxK8iMilWuQLcltYepG
 BGNkLo2yyRW/11Cp8PvHUQcdr/+Obe157DPg4f63MeUxl7ILsp82XytDBikGRwDwIss+
 9qBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=f0eetE3DrEYCeKphQixafEV/ofep6AsIsldocVx6x48=;
 fh=7k1D6ZMdWLOg3n0PpKnT42M8kalarWmHSjPbsfFuqkw=;
 b=GglABPeXSEfTSt4gIXiNqi/azLZabmbJ6F0wkZDf2qjG52BH1VIQ++fLHhdzp0ajU6
 WewFPU2EZXdZjP3Q/QlG87RfSPpxYbAy1kKFMawneOuPclGk8O8mqLYX0CZ9wI38fCm6
 MMpXmkgVyWPPkFsRS7LNWEpmyxsJgGEVn/Nq7pC5Z7HHNst0OcA0V8rmx/bktHjzch03
 JK0iuJ7JJqh/x2XzsYBKuFOGb1FegfwHbjbiY4DwS5mRXG+W1kkCZ/CYwBQ17OjMF+IX
 jFYvAXozkFO+Skd8kW0w182jnN/0qTeYEOvt+X8mm4Qp9YEz5QPLESnOcAzviPqICM7R
 0D3w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773412199; x=1774016999;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f0eetE3DrEYCeKphQixafEV/ofep6AsIsldocVx6x48=;
 b=IeOr6Nx00q+r/i4zhCAkADAQL5xEaHdmHJqCHVjJaHCscXUBA/rM2sd8EV3clSsYTE
 XxuKva+2hqypr7iUgWcekWsZ7WoOBYjHNS2dzbZOqZ4RY4z+STRMRncTTdcjDoiAXgE/
 qvMpf+hYInslT3d6MFSuAJUcEOAaNrBkflusoqhTQ+vPM6QJSqz/gG8tcLscu56E9Y5i
 ocOp6yX3pnsk4mhyWMZaTXlvwEPOZDbwSW5eCCPWkevPa81TDVT556RO0KiwPrVZQFsV
 Ys11wEb4+BBfw+JdH162SsGlZV0BzrZvLweyWOogRMVY7isUiJUcuwDg9lGCkeqeeOwW
 Q1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773412199; x=1774016999;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f0eetE3DrEYCeKphQixafEV/ofep6AsIsldocVx6x48=;
 b=acWn0MmGjrpBeu7e4nDyQ4jeITHpW5RaMndw8R/nVTf49HTG+UmgmmPttTJLHBp5Ur
 Og+2bEQ93o6kESLMABkA3dbwd8+OJHr2iLV48TxyrEo4ids5EgHOlOHqP+qLwczJoXwP
 HLjq7FhGd9EgiqS53f8ibVq3Cb49hgLLDqMUqwfP0+j+3YEQ4bilvR86CeZhdtO0WZDO
 tI7fiu6igLiDIuI34PplxI0x+TsqIEUGHXCcmLHDgGzdawwbS5DTs8HtcIVywAWCCUbE
 48IdN/0t+X3mTtn+JdaiQEs9jqCP6uHYkiud0Z39WdeyA60idtm/A7bx6NMyoCnv9Zwz
 Rd2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIliHt9d6B687recUw5fvd7bXfgRoraDvmejjH8k9kisluaYX2nZalbxCC27yhvTaC3qQPxo0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9dbtR5CtpW5MtREiRIKiUBuLfUlyBUVJa/OwW4log8bNeoSyp
 0zkHKRDzfM4nv73VZNvCJE1Yjp0mxrb/VcRnsM9UQ1XhLxQAsU4QgM57gtVgHFimL1MrLSZSnQv
 MU6gsys1Yr9iOOR5/lB0eNvOcm4JPN/s+i0LwgLIx3A==
X-Gm-Gg: ATEYQzxZ1bejKv8JCs1mhc7CuM72fj3PEUIpuB8cX8Kfa0bUbVRYpQ3LbZuLVKucRFh
 MtC02/2LWF6SsbYNdA8LqV6EjwKigSrQc9VesAWOW4XnnMZM53r58muJtXcBpYkELbDWHv0DmJ6
 w588vbEc/jg/RSNAaHgUpaKUrYAQrUaFOkAXqVZRQdJQqxXm2nk6/bY4HQ8znB0vdco59tomvfo
 6fkLEEcfg+TAAxb9tnfqiuAYAril8TQMjFhMnXf4I9plYlb1YosLv9U+LFnWzz2dFwaS2YUiDNK
 3CE+M1mL5QkWglCUO852ieWVcwu0e9iknyzrlS1Wx0kcHuwZ1e28p3XlpXDUjuEYJj5VEeJ2sL/
 hY4NK/C/iyrc+Uhud0Ew4x1p8Ng==
X-Received: by 2002:a17:907:a0c9:b0:b87:2f29:2060 with SMTP id
 a640c23a62f3a-b97651351c6mr235041066b.26.1773412199225; Fri, 13 Mar 2026
 07:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-0-b253b49f17b2@baylibre.com>
In-Reply-To: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-0-b253b49f17b2@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 13 Mar 2026 15:29:52 +0100
X-Gm-Features: AaiRm51SMLfDFC2jWhM0izfHg-SXAKNCTPocj6VBcjq2e4fCZz7uDxROPwsCFV0
Message-ID: <CAEHHSvZqqVa-NQmQO-SpZDczzBS3ZQoO5pkXjXqfJaZfD7Rdbw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] clk: mediatek: clean up flags
To: David Lechner <dlechner@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Le ven. 6 mars 2026 =C3=A0 23:07, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> The main point of this series it to get rid of the CLK_BYPASS_XTAL flag.
> It was a bit of a hack to allow mux clock parent arrays to contain both
> CLK_XTAL and CLK_TOP_* clocks. It's usage doesn't work in all cases and
> is easy to get wrong.
>
> In the meantime, we have added CLK_PARENT_MIXED and struct mtk_parent to
> handle mux clock parents properly. There just a few drivers that were
> not making use of this yet, so those are converted. Then we can remove
> the problematic flag.
>
> There are also a couple of other patches to give better names to some
> of the existing flags while we are cleaning things up.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Changes in v2:
> - Fix definition of MUX_GATE_MIXED_FLAGS to avoid compile error.
> - New patch to explicitly set CLK_PARENT_XTAL on fixed factor clocks.
> - New patch to consolidate duplicate *_PARENT() macros.
> - Link to v1: https://lore.kernel.org/r/20260223-clk-mtk-remove-clk-bypas=
s-xtal-flag-v1-0-a7dc97bc2660@baylibre.com
>
> ---
> David Lechner (9):
>       clk: mediatek: rename HAVE_RST_BAR
>       clk: mediatek: rename CLK_DOMAIN_SCPSYS
>       clk: mediatek: add MUX_GATE_MIXED macros
>       clk: mediatek: move common PARENT macros to header
>       clk: mediatek: mt7622: change to struct mtk_parent
>       clk: mediatek: mt7623: change to struct mtk_parent
>       clk: mediatek: mt7629: change to struct mtk_parent
>       clk: mediatek: set CLK_PARENT_XTAL on fixed factor clocks
>       clk: mediatek: remove use of CLK_BYPASS_XTAL flag
>
>  drivers/clk/mediatek/clk-mt7622.c | 334 ++++++++--------
>  drivers/clk/mediatek/clk-mt7623.c | 779 +++++++++++++++++++-------------=
------
>  drivers/clk/mediatek/clk-mt7629.c | 442 ++++++++++-----------
>  drivers/clk/mediatek/clk-mt7981.c |   5 +-
>  drivers/clk/mediatek/clk-mt7986.c |   7 +-
>  drivers/clk/mediatek/clk-mt7987.c |   5 +-
>  drivers/clk/mediatek/clk-mt7988.c |   5 +-
>  drivers/clk/mediatek/clk-mt8183.c |  12 +-
>  drivers/clk/mediatek/clk-mt8188.c |   6 +-
>  drivers/clk/mediatek/clk-mt8189.c |   4 -
>  drivers/clk/mediatek/clk-mt8195.c |   6 +-
>  drivers/clk/mediatek/clk-mt8365.c |   4 +-
>  drivers/clk/mediatek/clk-mt8512.c |   6 +-
>  drivers/clk/mediatek/clk-mt8516.c |   6 +-
>  drivers/clk/mediatek/clk-mt8518.c |   6 +-
>  drivers/clk/mediatek/clk-mtk.c    |  14 +-
>  drivers/clk/mediatek/clk-mtk.h    |  33 +-
>  17 files changed, 830 insertions(+), 844 deletions(-)
> ---
> base-commit: c0ca147ac6228949a6d6497531c9f2f4a0dc6c67
> change-id: 20260223-clk-mtk-remove-clk-bypass-xtal-flag-c2e2c82aabb4
> prerequisite-message-id: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@ba=
ylibre.com>
> prerequisite-patch-id: 81f2dd4fd7c1632736c08180d6b9f6aef5fe1e7f
> prerequisite-patch-id: 60f0509a5f36c2828316fa3e27dfd8f4d218eb27
> prerequisite-patch-id: 237c548edf19f9cf734b1ac3b9252a4f06d8cf29
> prerequisite-patch-id: 22de64f70e8d1ba5e17f8b31f461118b35e54f30
> prerequisite-patch-id: 3d5661f9e55292a30f57617848a7b10e67844402
> prerequisite-patch-id: ccbc73b2bc1dc41beb295604088d63773cea15ef
> prerequisite-patch-id: aa76b6b028374f20551955eafe56a1e0c1daa75d
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Hi David,

LGTM, tested on genio-510-evk and clk dump looks correct on the platform.

Reviewed-by: Julien Stephan <jstephan@baylibre.com>

Thanks
Julien
