Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66A6C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 14:06:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29BE587754;
	Tue, 12 Dec 2023 15:06:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BGpyuPTC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6032B87495; Tue, 12 Dec 2023 15:06:18 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E7C8874E0
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 15:06:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a1d93da3eb7so663645766b.0
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 06:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702389974; x=1702994774; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wXX1iaGCfPCSMkPGgKygBQAUep1rpecFSYqO9ePCG2I=;
 b=BGpyuPTCKvB+eiRrU9ghAWcqLJJ2IfXFij0YBKNlKH2hQdWR+s/HPiSACOIWJNiBcF
 dYDlE7/7Yje4cTzTNvThSmeGwROtcSxTpsnHfc5k0g8RBDiTa0ecbGt/IwORPf0D6ZuY
 hNt5jaG9GEPlGKJh4jdvxCt2QxfdUmd8Dp6VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702389974; x=1702994774;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wXX1iaGCfPCSMkPGgKygBQAUep1rpecFSYqO9ePCG2I=;
 b=wZiJ/TnN/yHQRfWHBE30hmlgVrLgmDohkeNOd1kOIGvMfG4r6E8fzvkUWjdP0+e4/6
 +6fIi/yFXRSZHcvrkMhNj+kW9lR1AmfKGa9HI8ZmWC0S5qJKcnn2L3hXepr0NDeGYGQ1
 O+wpFp4uD1TqKtLi5984wyDR/sYEncvasKpR3wz3EbBXc0EtyCFviz8EIZh1tac+tnnj
 bPW8igwOKwMClqgoGF3zS/4fgg1Fu2ite3hbRlNnQuzH3JZhmz4iBR6f8uCCIiTktEM2
 diGKmZC/vNCZLTIY4VGmhmW+0hN8d0OKkgSCv4ieOzTe+dG+p6uLMt99i2erNN059rk/
 Y+6w==
X-Gm-Message-State: AOJu0YypyQiGE5/M93jSL2+vwGH8Hsr/POnGAsXmgodEHcXGem9GLfCt
 GNzx6I/noRnziv1/OFOASvVlBO6sW205bgqkih9hlSYlTpMfJJKJyE9ibg==
X-Google-Smtp-Source: AGHT+IGCFVxztppksx+liUYRBJ3oULo0rwArDK1OGB9bHh1XvrkG6shq9f5SGMweQ30OGjmVLh8J6r+mqR+IrnGOoAE=
X-Received: by 2002:a17:906:6a1d:b0:9c2:2d0a:320c with SMTP id
 qw29-20020a1709066a1d00b009c22d0a320cmr3804747ejc.46.1702389973819; Tue, 12
 Dec 2023 06:06:13 -0800 (PST)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Tue, 12 Dec 2023 07:05:56 -0700
Message-ID: <CAPnjgZ06s64C2ux1rABNAnMv3q4W++sjhNGCO_uPMH_9sTF7Mw@mail.gmail.com>
Subject: Proposal: FIT support for extension boards / overlays
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>, 
 Andrew Davis <afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

The devicetree files for a board can be quite large, perhaps around
60KB. To boot on any supported board, many of them need to be
provided, typically hundreds.

All boards for a particular SoC share common parts.  It would be
helpful to use overlays for common pieces, to reduce the overall size.

Some boards have extension add-ons which have their own devicetree
overlays. It would be helpful to know which ones should be applied for
a particular extension.

I propose implementing extensions in FIT. This has a new '/extensions'
node, so you can specify what extensions are available for each FIT
configuration.

For example:

/ {
  images {
    kernel {
      // common kernel
    };

    fdt-1 {
      // FDT for board1
    };

    fdto-1 {
      // FDT overlay
    };

    fdto-2 {
      // FDT overlay
    };

    fdto-3 {
      // FDT overlay
    };
  };

  configurations {
    conf-1 {
        compatible = ...
        fdt = "fdt-1";
        extensions = "ext1", "ext-2";
    };
  };

  extensions {
    ext-1 {
        fdto = "fdto-1";   // FDT overlay for this 'cape' or 'hat'
        kernel = "kernel-1";
        compatible = "vendor,combined-device1";
        extensions = "ext-3";
    };

    ext-2 {
        fdto = "fdto-2";   // fdt overlay for this 'cape'
        compatible = "vendor,device2";
    };

    ext-3 {
        fdto = "fdto-3";
        compatible = "vendor,device3";
    };
  };
};

So FIT configurations have a list of supported extensions. The
extensions are hierarchical so that you can have ext-1 which can
optionally have ext-2 as well. This allows boards to share a common
SoC to add in overlays as needed by their board. It also allows common
'capes' or 'hats' to be specified only once and used by a group of
boards which share the same interface.

Within U-Boot, extensions actually present are declared by a sysinfo
driver for the board, with new methods:

get_compat() - determine the compatible strings for the current platform
get_ext() - get a list of compatible strings for extensions which are
actually present

The extension compatible-strings are used to select the correct things
from the FIT, apply the overlays and produce the final DT.

To make this simpler for the common case (without extensions), we can
allow multiple FDT images for a configuration, with the first one
being the base SoC .dtb and the others being the .dtbo overlay(s) for
the board:

confi-1 {
        compatible = ...
        fdt = "fdt-1", "fdto-1";
};

Comments welcome.

Regards,
Simon
