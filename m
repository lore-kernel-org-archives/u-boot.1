Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5570FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 07:43:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F9AA84255;
	Mon,  4 May 2026 09:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ntgJPh4q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EA5F8432A; Mon,  4 May 2026 09:08:18 +0200 (CEST)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C58183EF9
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 09:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matteo.guglielmi@gmail.com
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64eb84d1e37so2747016d50.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 00:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777878495; cv=none;
 d=google.com; s=arc-20240605;
 b=RizACS9bSCd1igZQpszN+rJ9Eil90NZ1T8AcPPIPctJABwtImZejK6PzceF07u161L
 O0AfST9tUExOK7zpL61NbuVoeFoQ/RYeX+y+B4Egu80kk54pvQecPithdGo8VhGcghZW
 EfLOr6P3dZ9NJ/SB3HrdotDzMi8hFWAYLG5DQYvFOHse2Pz7u/IewFmLCW8oqO81Fe6Y
 H2TrZfiyiDFrvPb+9brUs/VcJ44hYIQi+8JD5MHEDTwy1bmFtaCgcLJCUt+AHhgOv0/1
 JYd7EBz1b3qdnxPXTlNprmCBoFvfinlG2a4ee8jGmy7RlR9CFLP61WEZ2Y/rRhjQ+Gy7
 Aehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=cwUb1FWUWw5StYQcqEipWiWNvKV0Pc6TQcFw25SGokA=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=FR4TXaCbJFiIwDPlfmbIjw7OPxTRdTJodCjO0Uim4Vu2WP44DX2FJhg5ne53E+YdRr
 Q+h8ADoK1nIHQurrDoFURVBjmfRYP9/FAfXGB1TX0e1ZklcycKl2mbTrDx7t8da+Qe/t
 8CK1m9JRiUNIs7xYx8wRQRZLSenJx4vKUa+7zTiUgM4EWqqOPI6ByQTzeKHhiYuvV4AN
 FXcaXFeOhvYneQkMGpXSBN66dbPq1oqecYLDl/Ow3fwIHCPexFcrVk+OKi61JcE3YDEf
 NnKT8+9IB8gCTWrOz0QoafaEPYwe0lteMYYJ5lF+vT/zugrcf7OY5pzzJnOjWDMq8isx
 +U7A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777878495; x=1778483295; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cwUb1FWUWw5StYQcqEipWiWNvKV0Pc6TQcFw25SGokA=;
 b=ntgJPh4qwInkC4jyf0ApvhNWqyEMSJmTZXOQREgM57ViE3MND2DSi5+Gk425apPf70
 2VAYvTCA5pG1Z0v2gRZZaHfuBtZhvyHaGTtIvy4uOy7cO3kDsnMzTuSMrlL5i5xgQZmj
 H7X515CPbxeziq2q68SLMvP41rebtw7vvlXRChh53Myz7ze25jAhz86srkcT7QOyMF8g
 FktaNtYT0HsGMA3ozsm0LiFjifgZBdLMT7vr9SjAws97wCg7MVTOgCqYNHXmtTY/cjQg
 poIsoeD78Kb4mGSbwgfC7oNdPeYtyUPJta1DSGk03ME/QZ+vpuwvMufID/hk3K0FavAQ
 Wnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777878495; x=1778483295;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cwUb1FWUWw5StYQcqEipWiWNvKV0Pc6TQcFw25SGokA=;
 b=FsdWQ98h8YPchvvpOgBX2zE801MqA9GpAmeXcY1WYO9a/menEEJ2EW8nngLVMkETF0
 qxp7E9I9Gv2lz9BFbrmq+yaLjXj8+DnNofIKEMhexa+VUYag1gggmgqk+n2SDjwoh0i6
 EknAQry7LJzOLUv4WzI83rl/wJjjnpgwUXIDLDwt36ydlR7UC2Y4aBwVqbSxijCIY8ek
 3L4VV8PwlGGqByIN3g8UPymmjL2Nf24wQbJvc/hfjl4x6mHS69By3rvwrcfKIFOfp15x
 IkMiMalFi1koXzdwqLs4SwtaIV7k5wMfy8N0MZEo17dq9CyHsATSBNLmkiYIaZD5lIPt
 UF2w==
X-Gm-Message-State: AOJu0YxvBuYeKs4UG/AVPXFEQVBLjvzfbc9PexejYp5mBIDHzUtWBT9v
 wabxWPmVYtPiw/vik6t4W8AljT81/N2DdsrvjcQUubGtzFlzJNrqGX/wmViCT8oD+IoaCdZO4a5
 7WAWdAQZU7dCb+mwlAEY7HfcFcdRLLX9FJkoxkFU=
X-Gm-Gg: AeBDieuGmY9MAlz1ywAnbPU8S0cgzmCJJXkvDhRE8JntpCGRUSFnOE+3p5qihcHJhHQ
 MHd72iWOJiWbG83MrFvSGoLmOa6TI2kqNg+Uyz/gkATYD4q4XBW/PEObSgLJFbTtONEon4oAybg
 UYXKofKFXwNHPMhWCyS2gi7OP9P5/i3ayyMAqST32fxlexz2sGi6ZEGXe2DhACgoQ2ylVA15z77
 P2U0uHTpU6PaFIveBiw5zi3LNYjdzuG3dhrlVFYbcKso+BMzhxTLI9REQcoHTKOQ2ZLJSp8/hwj
 QNXPjbfMJQJNCpSzxLKx
X-Received: by 2002:a05:690e:1c08:b0:64e:e896:a86 with SMTP id
 956f58d0204a3-65c3db39b1dmr8751137d50.36.1777878495033; Mon, 04 May 2026
 00:08:15 -0700 (PDT)
MIME-Version: 1.0
From: Matteo GUGLIELMI <matteo.guglielmi@gmail.com>
Date: Mon, 4 May 2026 09:08:03 +0200
X-Gm-Features: AVHnY4IqBgucdN7i8zcUHjJZX4XB5IQBblrPYrSX51azEQrWHDd25Kue-KnvhpM
Message-ID: <CABVgzFqe4Wj8DGJHFfwHgYy-As57CnmROXuyOnMhnEBwvJOZdw@mail.gmail.com>
Subject: Raspberry Pi 4 Model B Revision 1.5 and U-Boot >= 2025.07 stalls
 issue.
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Mon, 04 May 2026 09:43:56 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

TFTP downloads in U-Boot >= 2025.07 on Raspberry Pi 4 Model B Revision 1.5
stall during transfer (continuous T output), while the same setup works
correctly with U-Boot 2025.04.

Please note that U-Boot starts correctly, DHCP works, and small TFTP still
works, but large TFTP stalls (e.g., kernel or initramfs files).

On the contrary, Raspberry Pi 4 Model B Revision 1.4 does not have the
stall issue and can download files correctly up to the latest stable
version of U-Boot (2026.04).

Thank you.
