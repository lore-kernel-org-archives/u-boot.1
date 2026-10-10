Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A54ECA9EC3
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 13:12:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D35ED81218;
	Sat, 10 Oct 2026 13:12:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U4gicOBnbIEH; Sat, 10 Oct 2026 13:12:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A35B2811E8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791637930;
	b=aR57PCgCnNfTgVPNtXRLX8k9jU/WhY7nfwQnZdRPBC042DCBevXwRPmzkgAOeeWsFkpx
	 Jwh/csTiSQlYwzSNCIAvpQ1JmznsJYAF5aNzaVOx1vesL9cstCggM8zTzoKuWnbgmIkUv
	 k0OFnEFgOdFfwyB53C+F83MGWcKElIimRVnHKK4MjqXLjtAwl645qGbyzl1uPifJ2+6do
	 hehoaTzCVXMxobyQTjdHzsqxBH4IFVOnPoNCNshkeQ84cSewoIDQYCXXW2dizl49N9c8q
	 Z8xiVdETYKokB0Vhv9nuq0ukrC7pzWpXFCKIyBvsEQSzbq4zLA2BEFYOwsTAsdvSTLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791637930;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nkLdee+B1+9IE0HgDUVkW/F8NgqGxUYiCBrre58pKxs=;
	b=WcPSBxAnLengwED6MsGoZ3ZU3fuSyXv1/OipzJYIDozDFj8iDk6NxmgkQrm1mLUyGDea
	 6378VnWAokQVnShceTCb2PodhLcqSoEjKOjhgAioooS+nScVj/BbKc3qlE9LnumTGoORk
	 R3lnhNAeYJMfE3rPLUm44gtihZgGFqXL5lS2I4MdFKpUhB+N8v1DIz+SIVo5sA5z34lwb
	 Uem7UnoyoCKEZMwSiSiw650NV8C8/h2bXo4rZwkL7NevKfK0QlPNI/hwUcyGRMNIC9/8H
	 7nmMuqJ1U/1vxWFqii/2rIkSgiftfTc/7LD+P3EFPCNGIgyBiIG/yMuMpWEAMrusajQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791637930;
	bh=nkLdee+B1+9IE0HgDUVkW/F8NgqGxUYiCBrre58pKxs=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=L+uaY7mTm1NPk9oUp0jL8uE+fN70g+ffX1Z3deHOZLm5FcO7v2cIh6hHBf7e7mwqp
	 RqVK2rJXbq07hLX+E4AMvjvATg4zqfDuOOIxjfy83/fAdgCaOqwdtkyQfr+Ux1moYD
	 7NDfMYXxVtAHG/14Jz7bPpFeEUx8jHz3aYeXAPpgysGE25aj7K42A+PaqiXAnPwvF3
	 briD1f7vv3U/AjAy6fD8uGoaFvBAYTSHfxCxIJR3xQbv/F7bC22dEMm163rMPSs8Uz
	 WIqwqFQT4BfHUUBASdoCjhTRF0hBMSRZCOAOufMIiysFjJT4JXWJNJVVK7zOHMMkYp
	 60aPRyruIYZRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A35B2811E8;
	Sat, 10 Oct 2026 13:12:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D57B2156
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B36844080E
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d6wVoEiJrtq3 for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 13:12:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5055840809
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::636"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791637927;
 b=cehQ8TMv6utUzLe9Jyo+cRVBYzzrzpVpzcqvu6unBGu9MxhIfNKSZX61uxTdNr+bOTb8
 nd0Bxg4C7FAPOnkRUtg1MkULqBQy9vMMvOIBqit9nHPvsDbr+4Lp0sbUJjcsH7C4VKXeQ
 SBb2En0Xf94rMh6pGXp3dR64uG/Rhbej24xyFFwJ0I2IZz1h2JT3fcrRmo0EVQXfP7o2y
 Z5IobeQC6jadqq441Xc4u10hob4ZfW/eaBcMtEyKbVPEtldnjn5xZLYitf1TTXKyyn346
 vkhbqcbVtm3M1xPXtjIzdi6OIH1kg4gCzhkgO2zZfXMf6nCl39lloERKprWu1tWoEqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791637927;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=nkLdee+B1+9IE0HgDUVkW/F8NgqGxUYiCBrre58pKxs=;
 b=IXGI0chg6KqlT0qgUOPOIbRI5X1QQQgf1y3fOtl6gDwHjlZt+g5KDanpoVm9OiRAtJ75
 h1JAU41DYL/aBKcB3NyJUaYNzmaW+gTV06h1v23dO4i70CQuqkNdMPckIESNsD2XzIHDw
 XW5AnicVOqqk6uDJy9wN4hpbloRWGd2RNYlemtbsk+iGbBxovwmnNY7NcH+2TlBnqk1Cz
 bbqbSwnb4ubM2iXh0hnWwJpZhkrqtwB9EpNbD50EDByoRWSr4zbeLGSSK/YjQhmc+JJ3p
 ydoUXb5F7RLrf7oHTwz1oFec2ARKLOlI+1o2oaYQE1d+9M2gvoAaC/GXdYcIxofWNVQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=lc1GhoJw; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=lc1GhoJw
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5055840809
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:06 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c2e3846d1caso102169666b.0
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 06:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1791637925; x=1792242725;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nkLdee+B1+9IE0HgDUVkW/F8NgqGxUYiCBrre58pKxs=;
 b=lc1GhoJw9cro6Jl25TrtldtPg3mN6M2wEp3aWywcLIWXShomU18rCgp9eP3V/RWabd
 BFD1/ILRnCvU9uqjd/qtLO+YXpWeLkRGyDbupaEzrO5PkK+Tehdmrs5af33wc9/+jNz+
 oBYknL0h2NTThcMaRHVnx3mbWK3dJ9cFETuJinhSFLP0x4qy6izMcXoKDHzFzV5zdfxK
 R8a1HnrIcdfeRNjZNk+pfmJ3hUsRs2hEL+AIx+tnI1R6MJvOK0np2zv2nTHilklnd37i
 ZDVTtrYNYTDNxlPenhfLggFFPRn6BDhrxTaMPO9YUB5ErSX7pMnd5lQhNqp0lrJmNJfg
 1x1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791637925; x=1792242725;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nkLdee+B1+9IE0HgDUVkW/F8NgqGxUYiCBrre58pKxs=;
 b=jBCSkBH4KE5wHh3RKpi/GIvOmMp+kyRhXqKXyFaljbqYntTU2Sh+DogdFncyTLrmIk
 VwYbhGNdBFKxlg5nG5JkcuyjeOBG4HOT2Aa3WFi9LwDWQlnqs3/PMigblrEbMY4s6+Ae
 MzebAWQkdMdOpdhaXPWKXqaspS5A7nspNvTk3WfqyMxDR1MGhSt25m33MU38ezzFx9fN
 mDKHi1Mg8rokggci/7qvOpXQXuX+7hi9WddIsvD31Um8JNRfvTTwjdf7eb75ox0UCxaH
 dr/wZyWVil/DggZ3K1YoDCfueHQF7q0R25DXdm2mTGYofU7fvGtzXjA9iy4qY1yfkgDU
 e8qA==
X-Gm-Message-State: AFq9FYLak/5rPJ73pvnB2QZ5Cn9mc+m0ZpQhMOx3M6BxVWpV62J2u0Cm
 YdGdUdrSpLbhAVPWtWCZ6kpX58TT2CT4iiCvrF8szmlA+6mjPRPMfOueUmcuu93TxfgKEc4twqe
 UNUr/VRXngQ==
X-Gm-Gg: AYBFou3d7pdFynsCCmw52rH2pIiLuiphZ4GtPwiJLQYp0fdqRVaOeHWeNUDMDfqv5Ox
 vPyyDzV23R9r2MrawdNYp4nVE0O6n66i5MR2QKx2MhQZ9R3QRfkMaDj8fSCcZbY4t+uiJJUMeOM
 baaIpkvgFF7yFZN7AED2XVFtpwKGyxMKuVejfunfx/5IGCPK/5jt7kmvbTqIX0ZUvTWMlpg0CXJ
 ZAhbARAXjwSad5ArLPJ19t/A61hHLzVi6i1nG3fZrDsVOna2exyPdAw+PXOe1/qdqNTqt7DWp8a
 AyKNM35YYeym5XsvXUA8ADGZ0cVoviufLkpEZ9XTl87ST2I/HWOfTe5JCbQwPK6Ss6yU3LZ9NqJ
 rUGa/Ms405VDNhN2NsrWGYg1KMyUWILLrmIOPlnW93lI2+rSkk9RYufHRtfwnjyl0umOn8TS11U
 z4BvbwO6FCS5DoLYm3Yqx3FibbGtwhbLcIGayS8w+haN6JoDdNW9TqnYJVrMrlTmaQB/X9rRBB1
 TsDjW0EF8ydWr7No5Nu
X-Received: by 2002:a17:906:d54f:b0:c2e:7fe7:289f with SMTP id
 a640c23a62f3a-c31a9d31c9dmr473956166b.25.1791637924613; 
 Sat, 10 Oct 2026 06:12:04 -0700 (PDT)
Received: from alchark-surface.localdomain ([185.209.196.154])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9a71d42sm240051766b.32.2026.10.10.06.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 06:12:04 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v3 0/7] disk: Fix the GPT layout on media with large
 logical blocks
Date: Sat, 10 Oct 2026 17:11:37 +0400
Message-Id: <20261010-gpt-4k-v3-0-89fd290f85cb@flipper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WPyw6CMBBFf8V0bQ19CNSV/2FcFJhC1UBtS6Mh/
 LstGI1xeZN7ztyZkAOrwaHDZkIWgnZ66GNg2w2qO9m3gHUTM6IZzbOCEdwaj/kVq7ISwJRseMF
 RLBsLSj8W0em8ZjdWF6h9olOj084P9rlcCiT1/qSB4AxLpogiebVnEo7qpo0Bu+vBo6QN9AsKU
 n5AGsFGgpK8EBSE+gXndZCF+xgf9O+V8/wCevoetP4AAAA=
X-Change-ID: 20260731-gpt-4k-f8b9e3fad474
To: u-boot@lists.u-boot-project.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Denis Mukhin <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>, 
 Paul Burton <paulburton@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andre Przywara <andre.przywara@arm.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Anton Burticica <mouse@ya.ru>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8482; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Qd4Df1gKbu3Wu6QUnrRpMWFqHo5+sgbK7IMrHrbjFZY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSdspwp6RyjkLPVv/rnv1ffX6z1klybeunirSleUVzci
 6sm2O//1DGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUH2Rh+O+3omGq5DWPT0pTLv0/cnrzmY2fVj5SNj7n+OjKMn1L/Txehn/qKz/
 yLqpbfJJ3n/N0bp0u6ati+cL6TuVXA96FT5gRtZwRAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

The GPT partition entry array is sized in bytes by the spec, so the
number of blocks it takes up depends on the block size of the device.
U-Boot got that wrong in gpt_fill_header(), which reserved a fixed 34
blocks at each end of the disk. On a device with 4096-byte native
sectors, such as UFS flash, the backup entry array ended up 28 blocks
short of the backup GPT header instead of immediately before it, and
roughly 114 KiB was wasted at each end of the disk.

Patch 1 calculates the count from the block size and makes the four
places that need it share one helper, to ensure they don't diverge as they
currently do. Note that it also changes the 512-byte layout
for boards that do not use the default entry count:
CONFIG_EFI_PARTITION_ENTRIES_NUMBERS is "default 56 if ARCH_SUNXI" and
is set to 64 by a number of Rockchip defconfigs, and on those
first_usable_lba moves from 34 to 16 and 18 respectively. Existing
tables stay readable, since the entry array is always located from the
on-disk partition_entry_lba, and only newly written tables are
affected. Partitions given without an explicit start= will be placed
lower now, though all in-tree boards either define explicit start= (thus
are not affected) or don't set $partitions at all, meaning a gpt write
would fail on them anyway both before and after this series (as is the
case of Khadas Edge2 - note that its listed maintainer's email address
bounces).

Patch 2 has grown since v1. It started as a big-endian correctness fix
noticed while auditing the file, and once the new test in patch 4 could
drive a real block device on a big-endian target it turned up two more
problems in the same family, both of which make a table written on
big-endian useless. Note that the switch to charset.h helpers for proper
UTF-16 to UTF-8 handling suggested by Heinrich is left out of scope, as
it would lead to unacceptable size growth of xPL builds, and those helpers
only currently support native endianness anyway.

Patch 3 from v1 was dropped in favor of outright removal of the old MAC
partition label support, as suggested by Heinrich (already in next).

Patches 3 and 4 add the C tests, which are complementary rather than
alternatives. Patch 3 drives gpt_fill_header()/gpt_fill_pte() with a
synthetic descriptor, which is the only practical way to sweep block
sizes from 512 to 32768, but it can never reach anything that touches the
medium. Patch 5 backs a blkmap device with plain memory and does a full
write/verify/parse round trip, covering set_protective_mbr(),
is_pmbr_valid(), gpt_verify_headers(), is_gpt_valid() and
part_get_info_efi(). Both live in the lib suite rather than test/dm/,
because UT_DM depends on SANDBOX and test/dm/part.c is built for sandbox
only, whereas test/lib/ is built for every board with CONFIG_UNIT_TEST.

Patch 5 enables EFI_PARTITION and BLKMAP on malta64 so both tests are
actually built and run on a big-endian target. malta64 already sets
CONFIG_UNIT_TEST and already runs the full pytest suite in CI as the
qemu_malta64 job, and ut subtests are collected from u-boot.sym, so no CI
change is needed. malta64 rather than malta because hdr_start/pte_start
in gpt_fill_pte() are size_t: on a 32-bit big-endian target an
unconverted __le64 truncates to zero and the overlap check still happens
to reject an overlap, while on MIPS64 it does not.

Patches 6 and 7 add the sandbox-side python test. Patch 6 is a
prerequisite: test_gpt_write_part_type() never binds its own disk image
and has only worked because an earlier test left host 0 bound, so it
breaks as soon as a test binding a different image is added above it.

One known gap: test_gpt_write and test_gpt_write_part_type hardcode the
128-entry 512-byte layout, so they fail if sandbox is configured with a
different CONFIG_EFI_PARTITION_ENTRIES_NUMBERS. The new tests derive
their expectations instead, and pass at 56 and 64 entries. No sandbox
defconfig upstream uses anything but 128, so I have left the old tests
alone.

Still not covered: gpt_verify_partitions() and friends now have
big-endian coverage against a device U-Boot wrote itself, but nothing
checks that U-Boot parses a spec-conformant table produced by someone
else on big-endian. That needs a real disk image attached to the QEMU
target, which means teaching u-boot-test-hooks to pass one and, for the
4Kn case, using virtio-blk rather than IDE, since drivers/block/ide.c
hardcodes ATA_BLOCKSIZE. I am happy to look at that separately if it is
wanted. Likewise, blkmap devices are fixed at 512-byte blocks, so the
round trip in patch 4 runs at 512 only, and the 4096-byte write/verify/
parse path is only covered on sandbox (patch 7) - thus no BE coverage.

Tested by building sandbox (default, flattree, sandbox64, spl, vpl, gcc
and clang), generic-rk3576, sonoff-ihost-rv1126,
A20-OLinuXino_MICRO-eMMC, turris_mox, boston64r2, qemu-ppce500 and all
four malta variants, with no new warnings on any commit of the series,
and by running the full sandbox pytest suite plus 'ut lib' on malta64
under qemu-system-mips64.

CI for this series: https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1537

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v3:
- Rebased onto v2026.10+ (main branch)
- Patch 4: run the checks in a helper so the blkmap device and its
  buffers are released even when a check fails (thanks Simon)
- Mention that sunxi and rockchip boards defining $partitions already set
  fixed start= (thanks Simon)
- Link to v2: https://patch.msgid.link/20260918-gpt-4k-v2-0-daefa4792e9f@flipper.net

Changes in v2:
- Rebased onto next
- Patch 1: reword the commit message only. The entry array is sized from
  num_partition_entries and sizeof_partition_entry rather than a fixed
  128-byte entry, and the two counts that could disagree are now named.
  No code change.
- Patch 2: also convert the protective MBR fields and the GPT partition
  names, and fix print_efiname() to match. Both were found by running the
  new patch 4 test on big-endian, and both make a table written on
  big-endian unreadable. Dropped the v1 Reviewed-by tags from this patch,
  since it grew three hunks nobody has seen.
- Patch 3 (old): superseded by the removal of part_mac
- Patch 3: moved out of test/dm/part.c into test/lib/, so it is built and
  run on boards other than sandbox.
- Patch 4 is new: a GPT write/verify/parse round trip against a
  memory-backed blkmap device, which covers the paths a synthetic
  descriptor cannot reach.
- Patch 5 is new: enable EFI_PARTITION and BLKMAP on malta64 so both C
  tests run on a big-endian target in CI.
- Patch 6: unbind the 4096-byte device at the end of the new test, so it
  does not leak into whatever runs next.
- Link to v1: https://patch.msgid.link/20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net

To: u-boot@lists.u-boot-project.org
To: Patrice Chotard <patrice.chotard@foss.st.com>
To: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Alexey Charkov <alchark@flipper.net>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Denis Mukhin <dmukhin@ford.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>

---
Alexey Charkov (7):
      disk: part_efi: Size the partition entry array from the block size
      disk: part_efi: Add missing endianness conversions
      test: lib: Check the GPT layout for large sector sizes
      test: lib: Check the GPT round trip against a real block device
      configs: malta64: Enable EFI_PARTITION and BLKMAP for big-endian tests
      test: py: gpt: Bind the disk image in test_gpt_write_part_type()
      test: py: gpt: Test the GPT layout on a device with 4096-byte blocks

 configs/malta64_defconfig |   2 +
 disk/part_efi.c           |  66 +++++++----
 test/lib/Makefile         |   1 +
 test/lib/part_efi.c       | 283 ++++++++++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_gpt.py | 120 ++++++++++++++++++++
 5 files changed, 451 insertions(+), 21 deletions(-)
---
base-commit: 837387a5aebc5cd53b9143926891cec024fcad3e
change-id: 20260731-gpt-4k-f8b9e3fad474

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

