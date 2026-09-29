Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D92CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:21:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B9346070E;
	Tue, 29 Sep 2026 00:21:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HNLNdpjpjZtE; Tue, 29 Sep 2026 00:21:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2842F606F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790641313;
	b=TQINMsHgWLVBQBpafAkT8r69T2wcfSdVoVcbavzpb76vlA/IYcb52qVZTHIru6TGHqSA
	 E3FgD4Ym3C9wCsALIq8nSAexAFgf7+PTLEG7JhiB6SM9rd+gqn7plLIYsmoW88qBbR80P
	 7bBquarwOGgNMEt076zDS90pcJEv1+4+aIYUxZ7PKP6R33Hz4z0IA+2Gb6RCAYeb75o1S
	 LGlkcU8cC7ZNs23JorMGKrNpSi4HWcZvtDrZxcq+AjcLN0yKXWFUwaGtNQq5+rCVuMBo6
	 nLYMiDfeaT4ZRbB4CE3n3r6yw1AhNxo3bgmH1FsgtvdT2XYbRbogGWrlloUEHAoRh1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790641313;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=a2v1L+hqFWs/epbL3uhoNpljAmiVEvv7lHdIlg8saQw=;
	b=fJf6JQF4kkmSfqbm00ttHEiYowropjNOmU+mgjotKM3jWvOdRU0c0LEK1kVd92gFjz7i
	 2LSu1IabiIiPHS5HQMHYDlAde8kzGiwEQ4e1K+fPzGMe05EubFKwwzPMGV/wBCNZc37lP
	 JkIzNANabwhaqhFtUNSqhOFAvTLUQMPyiPut+fAW/EKxpoYRmZE2sUJJcgdgvE91qmW0r
	 kIv8wbRs4QaVYYu02Hn1kSJlnawBzGqC/bSHkvaplDevxZWvoV1IPf+zKaRKsvCNn9T9L
	 BUwlFR9mLN0OBmWAZOHDdwze2OaRzNRu86wYOvlzQmv/erHHMRGaAavNSawQ2vPBD3Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790641313;
	bh=a2v1L+hqFWs/epbL3uhoNpljAmiVEvv7lHdIlg8saQw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=l04LzSn8Ic80h1+DWgoj3snxIr2CjwEswjdItaeIGr1rU9PjwyajHG1FU+TEQxY1G
	 XShRIsKeXnroGRVN7hHVFPpd2wG/YKCSaqT2WkV4g9fVfva1hv0BAX8GUkVxvA8BTw
	 jKwGFYKa0X0uzQDshZ7EYM9qsPOmbDQCqaX41d3+mPrUvR83rMz/RxPmUF+WoHvz3B
	 X2tiaSRpfkh0nRxjIi1D8Kx0PWgV6RJhAb18dLQDOl2yVCwv8NeF0rB4OoKSyXAUop
	 +GbaZx4tMfKUzne8tIy5oRY8ILfpXK+IoNfIm5T0LCltVOgZv4Q/hwbLSy1apqNDh6
	 yqoQ0gCSyZpug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2842F606F5;
	Tue, 29 Sep 2026 00:21:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A56E261
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:21:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8CD7D80C16
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:21:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gEhP7kH5qPt4 for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:21:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AB9AB80AF9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790641310;
 b=ZTavB++IYek6UG1Nekv+59t9oqSMvUpPQcqms4fdZ14S5w79b1C7e0Ypc4bBJb6imTnJ
 aY4Xr4uuZApyG+Af0nTd67Pqr01TfxVVLMPuSAVYMkZMai1SFJ2a2ShTZCwaAe8B/oItr
 N7JPXyzI2GUvoVnW9vYDgBXhOHVKqoy+Djwr8y6JYTMPyi3murtnUC9PrzCv1pnKGbojA
 xwLur0P/M+v3Dix2udWPmW3Boh9ttrRXMVSF+wmbtFaE7yJYnJ0y3R3JuJ9hT/rPCzYfQ
 94MuycBkdZP6G3p9L38h4eohTWujuIVErRVnVRXi/kxxr1qtvUR2apVWNhonfQWvd+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790641310;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=a2v1L+hqFWs/epbL3uhoNpljAmiVEvv7lHdIlg8saQw=;
 b=b9Hdxmz/Ihy7hNOEMki2df+nQhX1/suxJhfxlkMbuI3NrB7ioHOhWxDTKue4S/j7LJgt
 VJYHt+RymD4VozyFBk1pZrod+eaLXgiMpqQCeQ6+hoxEPFQa3KI3S0xEqnqamYaVPTbrI
 NbEDAVfXbNzGiV7caCPKK66UcPcUe+AWJgLCd9Rdb1rblRMn2LTDmzNkwxVOJPmksqF+S
 9ST3Y7J5r8IrMowbV4DdrBDVRGLzesWV53kD0XBBMyOFkm4rKmoNjwceDZP01UkDhf1Rn
 zFAdRRkk0s0TyImatY38dj14RIgzy2PWN08ibtqqEclpeOf+4WiWGEWOkylTHUqmy3w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CumJYRfr; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=CumJYRfr
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB9AB80AF9
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:21:50 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6d8ac4fee7dso290901eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790641309; x=1791246109;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=a2v1L+hqFWs/epbL3uhoNpljAmiVEvv7lHdIlg8saQw=;
 b=CumJYRfrAzlrDso7uBpcIZY6eRdDLMsCzB4dU2kvKwcOMOuV2hFj5MF/R9e+9fex/E
 rMA4Nzyt8uwRB1QWec0GIAIy+RJzucK8NVv2QFtk/yoKu3uc/jLZHRG2ZotT3DHbbdqs
 lxSwYvYS6DsC4+sRGaSjTMokxbvtn2Hq8nfRDat++6PTWAXcwlwSAvt3xrIStPP3q+sh
 LXMTPFdgemk37SHm8Jn61JEbfmQa9MCgjAOPouLzokYQJ8U4iur7Lh9Z1g+kIBNvNKmI
 qGleEA2E6Yd2t7Wyz0MWPuWW7gI+JRijJIUHUTb63EEmo8u5Hyuk/8xRhREomdr2MBIK
 x/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641309; x=1791246109;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=a2v1L+hqFWs/epbL3uhoNpljAmiVEvv7lHdIlg8saQw=;
 b=cmqSwoYcdpf5COw9SLB/PlHZHUwWka+Tai0UnwljkVqQFB91nTHuZFhAR10AlWzP1K
 8g2M6pIlIQsB8qT5oTp07vG5Kqs3TKJkinnB0uq5IMSl2AywjF1tRgzBP9cfpTS7EFza
 lObK/bYTsXhpPXF12C+WExsiUXwtone+4N1fZNCBSie/bGRZW/atjwQV2qkoCCmkviAM
 7ZwbxXmoZEsW84Ds+HAdPkS9R29J92xnD1NuoDbyZCt67Xa7lmIZGqQGYXo41j58F3m9
 Ho8KYZHgY+IAo0xYgyp62vhk+DLs7bKB/ZHlzNJwLL5eXUDehdgT4D6nKK5jBhTNx4Ad
 mGCQ==
X-Gm-Message-State: AFuF++kdIlEW/sosW8D65L92WLLZDtYTT46FU6Qg5XfaTxHiPuYLwjrM
 nc9u6BrAfe3n6MWyp7606F5bra71RT0YwjPB/MlIQp2dIpriN/XZAavU
X-Gm-Gg: AYBFou3ya9hdeA0wje1JNjI9rTs24R2HLCAhgOW9sY+XjguC8SIezM88lBY70dMp7WK
 2R2v/kl/YwHQaZAir0Z1pHg45GPOXX59LUczHHczHZxWRuSfkOKBUqbIhKJKtt0MMSMBL9MhXGS
 mKT04xvGa5BR7CoLxQmPFgyHnxZfVvxoX5aBIaVxeAYjRuCVNREWxx/H3MXdjsjg1ABMvdejWwY
 pTG7NryydJ94VmbiWLP2gl1CzG5SPX9XM1fVLoUK7dUjKhbYMryOTOGQ8VNNHFFFMq6QQovJuqc
 StuKZ3fWEVMUXY9SldP2w6X4QWtWVJxbzLUGBNdDAaO3qrRFQzaplZOXFL1Loxk6IhDNFqhEncv
 znzlFlyaGbVpBmgavZCFEk2XS2yuAjr22ZND06DhlE8oWAHD3y+zdL5Qje7Ka9T2M7qkiI205ml
 QFEb4sasbYMNtFKtWZALSatbu2CXssM2wI2DOxqVwCJWYQ0tosrlZKJG2koFGGrJDRlnPKaC2FX
 vah9o5R7dMZXmjcO78IdBIDo+I5VHmGTNRyecKDU9AeOkKPSnidLp5VN66ecgV1+zkM5RwQsXkI
 vxoN+H88O9Uy5y642kWAnIe5oMuOalinFlp/YYq+R/l/wJC2HFtiz0ic8bxM7zy1jLuNXf1xQdC
 fiNbPWkcTwJXe2gTIe5Iv
X-Received: by 2002:a05:6820:16a9:b0:6b5:ec2f:3567 with SMTP id
 006d021491bc7-6db14404384mr580268eaf.24.1790641309007; 
 Mon, 28 Sep 2026 17:21:49 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-494877590e5sm8175688fac.13.2026.09.28.17.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:21:48 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH 00/20] net: lwip: restore BOOTP, DHCPv4 boot policy and PXE
 parity
Date: Mon, 28 Sep 2026 18:21:37 -0600
Message-Id: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ7CIBBFr9LM2oktVkGvYlwAHQWjlDC0Nml6d
 0GX7+e/twJT8sRwaVZINHv2YyjQ7RqwTocHoR8Kg2jFqT0Lia+Pjzg4G3Hu8KBkr0j1Qh4lFCU
 muvvll7ve/syTeZLNtVEfRjOhSTpYV6cpck6k3/tAS4Zt+wJVVXAekAAAAA==
X-Change-ID: 20260927-lwip-dhcp-v1-38748e842757
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, Johan Jonker <jbx6244@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Peter Robinson <pbrobinson@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Heiko Schocher <hs@nabladev.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, 
 James Hilliard <james.hilliard1@gmail.com>
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

Restore BOOTP, DHCPv4 and PXE behavior available in the legacy network
stack.

Finish DHCP and release its address-less network attachment before the
requested download. Honor autoload=NFS, report unavailable protocols,
and restore the exact autoload value around internal dhcp_run() calls.
Preserve explicit filenames and configured boot-server preferences.
Include the NFS filename parsing and ownership fix before the autoload
changes, so IP-prefixed NFS filenames work safely without a separate
series. Use the advertised boot server for NFS while preserving
explicit overrides.

Carry hostname, root path, boot file size, NIS domain, time offset,
NTP, DNS and boot filenames into U-Boot using the existing BOOTP
controls. Validate and stage metadata before accepting replies, then
publish it only after binding. Retain defaults from the selected OFFER
when the ACK omits them, without inheriting another server's or a
previous transaction's data. Handle overloaded fields and split options
with bounded buffers. Export DNS independently of whether the resolver
is built, and do not read stale resolver or SNTP caches back into the
environment.

Send PXE architecture, UNDI and UUID options, including the bootp_arch
override used by EFI boot methods. Request and retain the option 209
PXE configuration filename. Cache the accepted wire ACK per interface
for EFI consumers; move the legacy cache update from OFFER to ACK as
well.

Accept direct ProxyDHCP boot replies independently of the address
lease. Consume zero-address replies before lwIP's lease parser,
preserve the selected address server, and poll during a bounded
post-ACK wait. Take only boot information from the proxy. Keep its
reply separate from the unmodified lease ACK for EFI consumers.

Honor the legacy acquisition deadline, configurable retransmission
intervals and network retry policy. Retire DHCP before switching an
exclusively owned interface, discard pending metadata between attempts,
and leave other runtime clients attached when retry is not possible.
Ctrl-C does not trigger another attempt. Populate the elapsed-time and
requested-filename fields, and make the remaining DNS, gateway, subnet
and default-autoload controls available with lwIP.

Expose CMD_BOOTP for lwIP with a standalone BOOTP exchange, including
plain replies and RFC 1048 extensions. Reuse the metadata, retry and
download paths without requiring the DHCP core or accepting a DHCP
offer as a BOOTP assignment. The bootp and dhcp commands can be built
separately.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
James Hilliard (20):
      net: lwip: bound NFS filename parsing and release its copy
      net: preserve the autoload value across dhcp_run
      net: lwip: finish DHCP before starting autoload
      test: net: cover lwIP DHCP autoload handoff
      net: lwip: add a hook before accepting DHCP acknowledgements
      net: lwip: carry DHCP boot options into the environment
      test: net: exercise lwIP DHCP boot option handling
      net: lwip: export DHCP DNS settings without a resolver
      net: lwip: honor configured DHCP boot-server preferences
      net: lwip: support PXE client and configuration options
      net: cache accepted DHCP acknowledgements for EFI PXE consumers
      net: lwip: honor DHCP timing controls and request header fields
      net: lwip: add a hook before parsing DHCP replies
      net: lwip: accept direct ProxyDHCP replies without a lease
      net: lwip: retain boot metadata from the selected DHCP offer
      net: lwip: retry DHCP acquisition using the network failure policy
      test: net: exercise lwIP ProxyDHCP ordering and validation
      net: lwip: separate DHCP exchange from boot configuration
      net: lwip: support standalone BOOTP
      test: net: exercise lwIP standalone BOOTP

 cmd/Kconfig                          |   59 +-
 cmd/lwip/Makefile                    |    1 +
 cmd/lwip/bootp.c                     |    8 +
 doc/usage/cmd/sntp.rst               |    4 +-
 include/efi_loader.h                 |    7 +-
 include/net-common.h                 |    8 +-
 include/net-lwip.h                   |    1 +
 lib/efi_loader/efi_net.c             |   72 ++-
 lib/lwip/lwip/src/core/ipv4/dhcp.c   |   39 +-
 lib/lwip/lwip/src/include/lwip/opt.h |   67 +++
 lib/lwip/u-boot/lwip-dhcp.h          |   28 +
 lib/lwip/u-boot/lwipopts.h           |   78 ++-
 net/Kconfig                          |   43 +-
 net/bootp.c                          |    6 +-
 net/lwip/Makefile                    |    4 +-
 net/lwip/dhcp.c                      | 1093 +++++++++++++++++++++++++++++++---
 net/lwip/net-lwip.c                  |    6 +-
 net/lwip/nfs.c                       |   70 +--
 net/net-common.c                     |   22 +-
 test/dm/Makefile                     |   12 +
 test/dm/lwip.c                       |    2 +
 test/dm/lwip_bootp.c                 |  573 ++++++++++++++++++
 test/dm/lwip_dhcp.c                  |  350 +++++++++++
 test/dm/lwip_dhcp_options.c          |  691 +++++++++++++++++++++
 test/dm/lwip_dhcp_policy.c           |  286 +++++++++
 test/dm/lwip_dhcp_proxy.c            |  461 ++++++++++++++
 test/dm/lwip_nfs.c                   |   61 ++
 test/dm/nfs.c                        |    3 +-
 28 files changed, 3862 insertions(+), 193 deletions(-)
---
base-commit: 2b8902913c19eb581fb0d567201c09b8fa46ac74
change-id: 20260927-lwip-dhcp-v1-38748e842757

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

