Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D344606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 07:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RkHj7TLo;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tsc6KI1o
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DAC266069A;
	Wed,  4 Nov 2026 07:17:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WtS7JGDYf8et; Wed,  4 Nov 2026 07:17:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B427060686
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793776678;
	b=daiCqYdKiXu15BLrCwAXe2mN6v1qCwQw4y8mtS4RzvLx7hmvo7SMKooaODR/N7/Y9lwL
	 Bk0/sXqi2P7HWwzyKfsIyOC6SvjTMxMU4+0xynMrYAl6aizDVvLQw9h7SzKUo0nxgKdKi
	 ap0tb6MyAIzDZHUpsjxb/MCvtZ0I5Z+YjnkexzV26k3B9FB9xZk4lQIEXsHvpEOa/CZmc
	 xVDW3LFs7YQgz39AHx2mTReuJjPrxqNBBdeVqJOQE/2GXm7yt13Xl0O2XQv14z3vRntiz
	 6NIL/yupN7WHmevtEbSZVSMii+B0G9BCbvhBPBM1Y3X75JgdfnDE4MR+JUBv/re7e5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793776678;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hSKWFbnrb5fcIOjyHmJ6F46Kvg/ekV/70+BCn34cz20=;
	b=jHQK69oEvakBhLA9XkGszO9813TyWU8Zg2JfUI8syf7pf5EpKvArKDn8yHpCUfsY62cL
	 rqc86zLePOP2w2KPBdnEqD/nWdKttaigNm8hCLbLL5h0+PL2T/Ao6YI0rIQ7q81kFE3aE
	 mf1moOZdVTfBBxXYqDPF2ZD8s5HRHhFT7hJi6f15u2xSbX+b+h40SyiCwenGtU5W7yTC1
	 z1sqGm61kW5Y5L8qfW0AuJmPdJYvIoMKrxk9FQWY1erzi2ai0oijn1x/bhsH67Bu7HSp+
	 0redDteHc6xih2MbgitM2TXwFg6KxYacDYU95yPnkzY/pzmZEz9htyv4YmSwsoA5sig==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793776678;
	bh=hSKWFbnrb5fcIOjyHmJ6F46Kvg/ekV/70+BCn34cz20=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RkHj7TLokGIx/mt5dfOOU/cgaOkgJyycKsx+dV4dh5+99sWUgi3T04LDj1WEI/lca
	 QUkSh9sDM+KeX7NJHkSHbJf3dxh60F14g9mDJ1/bLkLspjokfNEjGvo9neLzDdGTt7
	 FhOPe5FTWre0taC2L5do3xjFboRy9YpjQD/IYsqW8EGcLuFCqhRfPwT5NtZfYWg50c
	 KKmDbTWg6rYhDjx8DEktXHOVzjo2/ysy4olbu0qRpdf2WOWRutFBQvvTax28PZzih6
	 FMhfZ/pmtPgxJfN36qtFkuO3A762imG/Qq01aad3GG/8vHTj0HxwyP1fhCM0+Ewr2x
	 sWSMpBjCG67Qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B427060686;
	Wed,  4 Nov 2026 07:17:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CCCB341
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:17:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E23E405C9
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:17:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id juCySpmBIGGT for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 07:17:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BBAE6405C6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793776676;
 b=bkm89ldntUAmMFi4tKGsy59lv5ZVlpX3TSi7XdbEajKSJkdIL23/WCSdKYYHpPVHrK+d
 51xMpu9zUL5k0T0DJl2o5rxxYEOkTgrGOcdsVyjGhxHyFUnffr3FiXs9/m6J3mu0kYKbb
 r9G6MGaeo6A1lxdPSALeyQ1InJHa00VNPFtcETN96/ol5cDF3YOWh819ql0FFm/qMAxzE
 YByvhl63FDxUZ1Yf2mB678441GgSyPT9WokF2LRsODNvlgLrqyT9XPJJ69vMtKG4g5J3/
 4aTY61XTdrKo6FiU55TqdE2PJtzzzCqCzTswoBLZCLxFvzqnqd8EFHMM6qKuR+X4IQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793776676;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID;
 bh=hSKWFbnrb5fcIOjyHmJ6F46Kvg/ekV/70+BCn34cz20=;
 b=CIvtCSoyQTXdS9rusIwAQKcPwrRkq2c/Cnss0GL8DFSFx790zrPOmBy+WYV/7SxXUhlq
 raWF4QXDvg/mCs4t/2GZEcBfk7hp1dCv5hHyizkrcnsXUmYvrUO2z/rNZ8h1TVbQDadHE
 VSu+8xzq3vyUk6SS28EIEzoG+DBTZB1jsE5xlb2jUeo8zylqhSLbIlhlenfjXEys/rIcQ
 3izLT9pxs2OAuN9H7bKT7yvtOO5jbBI4V9iQoxibrQVm9AHEnobJDXV9dYAzjIj0CMq9X
 bWdatFp1aXtrk7cXtoTMg0tmNHS/xIwps+JEtY6W+NON0e3i6zHDjhRwA6H/iyky9mQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=tsc6KI1o; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=tsc6KI1o
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BBAE6405C6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:17:55 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48e0d1da913so176436f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 23:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793776673; x=1794381473;
 darn=lists.u-boot-project.org; 
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hSKWFbnrb5fcIOjyHmJ6F46Kvg/ekV/70+BCn34cz20=;
 b=tsc6KI1oF2exIveRRe9VbCcNZRlClxK/1lXlcxlpCgWrbK7zsVabOM5m7D7grCSQlU
 p67goIYwjUVQAuqadICaZJWcO0eRWsG17Mhs1kQvsdBEAVBJlC9APeqQoN3otZGsTIJl
 MTC8Uk59VGLgbPSGZWWP0O+d+86B+H2EexaTRb5Ak1R2arg3y4qPYLZBSst7IMTXK8RQ
 /cbr0Yey5qtkcwLWpnxxxixH7ktXqek6QWFfg3Dsdqbqzpjs0R0oaJVMpD8Q6XHFlWSJ
 DcfMBRqUsIOp5DH30/olEkxeMg+RC3O6KrHtJzdP14wfp2Ql0GABZTfge8AJZ5NjNg3k
 V70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793776673; x=1794381473;
 h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hSKWFbnrb5fcIOjyHmJ6F46Kvg/ekV/70+BCn34cz20=;
 b=z32KUDa5lZnO0TpSzCH6l2gAf7cjTzLbVyUY7R6YGrtXwR3W7ZU4GmhaAq/t3J0rh1
 PCtehd8BtbcWOswmT/XQIwFHgbAOU4l6x7/YBto9TookIE9mdUyjycO23yrM0lBDh3Gb
 8Yoe9ICTR4skj4ncgVfWssD3MhjRq/8oPLvBOborJtwJiK6ieRM5TNXV8vokqGxXZExh
 DBXNjdgnnStnZtg8cim3GFdh/+xt2jx7zKrsGxN7CjkmEaMqRlsMcj6wDzpGDq8Nl248
 hzM0qhGTkIuzxky9pbPSk9EVaWh4+YCM/PNkssosSdKHnevAPRlxMkwPhcg88SQLPTNw
 TOyw==
X-Gm-Message-State: APuU4Z8xSwLhNirHO9okHSjV5A+nBPpzzMFGX844lA7hDivKzfE7FfIQ
 qHMvuWDCMyQUHCZFpr41POCq+LZYBFbH3CjRUDw9yaJUvnJHkUNMBOBayZSfZNdf12s=
X-Gm-Gg: AYBFou0rY6yDLprFzBwTt6A9v+BIaLbyXDfs0sRDRrqZpgRXwuvGwQbrqqhcWRvjcMY
 12emOzTd6Xpob6U6K2dIYCIAX75i0JI00A4r5+UxVvMD2V8RU22x10aXx+bsbvmU0Fw9X6G/maE
 jXZoAsnTloSlEpWxJ5GXz1uAJQMSVdylSjCzdROtjYZDICO94/+Iy5VzZzfwLAerKN8LV1YrfjW
 zl+lVNbH8naa8ZNqceFLr344IzoRVrDQBBlN0YXYgAIR4aKeveaKmzDfQqhdIYhz2mtDnCyfL1Y
 awuhMd9qZHpB4TRtPa3D3rTs5KDNpJBvp7auSW1JAWGYLFRnSnIK0Iv2ESeYRJjVYwUX2U44f8f
 1dr5aPa5/5Y/qWVXUbY4f4qBgQTyfpuXSWRlStteQmxaVKx5UfHT1tIydYItaobW6xaa4RpfKb0
 wGARvDPpXY2i4cEUKO7cYFhO9AMQy2qN42fq8eC7qetJPp7sRmpaY/W/skTZOISKdJ9GlCCL6ei
 Bfdd+gg9lSEzfDkSrelg/Cxlylk4yrXV6JLuL1kyW4W0O/pkmqW8uOZisoan46B6JJkXb+7X6vB
 15tmPHTSrs+RSOq7VMeVZDj/j/rOIb0=
X-Received: by 2002:adf:e18c:0:b0:48e:eb:56c5 with SMTP id
 ffacd0b85a97d-48e6e2c1d83mr37695281f8f.8.1793776672761; 
 Tue, 03 Nov 2026 23:17:52 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fecac2772sm2112373f8f.18.2026.11.03.23.17.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 23:17:52 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@nabladev.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH 0/6] usb: gadget: f_sdp: honour a closed i.MX part,
 bound ep0 data
Date: Wed, 04 Nov 2026 07:17:51 +0000
Message-ID: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

The SDP gadget lets SPL, and the sdp command, act as the i.MX boot
ROM's serial download mode: a host on the USB port writes files to
memory and jumps to them. On a part whose secure boot is fused closed,
the ROM only runs an image it has authenticated. The gadget does not
ask: SDP_JUMP_ADDRESS first calls the entry of any IVT it finds at the
given address, before the FIT, container and legacy paths that
authenticate, and SDP_WRITE_FILE and SDP_READ_REGISTER take any
address. A closed part that boots SPL with SPL_USB_SDP_SUPPORT will
therefore run unsigned code from the USB host, past the chain of trust
that HAB or AHAB set up. Separately, two ep0 requests take the length
of their data stage from the host's wLength alone, against a 4 KiB
buffer.

Patch 1 bounds every control request's data stage to the ep0 buffer in
composite_setup(), as Linux commit 36dfdf11af49 ("USB: gadget: detect
too-big endpoint 0 requests") and barebox do: an OUT request that is
too long is stalled, an IN request is shortened. This covers the SDP
report 2 SET_REPORT and the OS descriptor vendor request, which clears
and returns wLength bytes of the 4 KiB buffer.

Patches 2 and 3 fix the SDP data path on every part: a zero-length
report 2 packet made the copy length -1, a report 2 sent outside a
download was copied to wherever the last one ended, and the padding of
the last packet was copied past the announced length.

Patch 4 converts the command's address and count once instead of in
each command, with no change in behaviour. It makes room in SPL for
the checks of patch 6 on imx6dl_mamoj, whose SPL is close to its size
limit.

Patch 5 adds sdp_is_closed(), a weak hook (false by default) with
implementations for HAB parts (imx_hab_is_enabled()) and ELE AHAB parts
(OEM closed or locked lifecycle), and reports SDP_SECURITY_CLOSED as
the ROM does. Patch 6 then, on a closed part only, skips the raw IVT
jump, takes an image only by a path that authenticates it, refuses
READ_REGISTER, and receives and drops a WRITE_FILE that lies below
DRAM or touches the loader's own BSS, heaps, device tree, page tables
or stack. A legacy image is taken only when its header starts the
range that jump_to_image() authenticates, since its entry point comes
from that header. Refusals are answered with a failure in report 4 and
the gadget waits for the next command; where SPL searches for a FIT or
container header and finds none, the jump ends in the existing panic.
On an open part, and on every other platform, the SDP flows of
imx_usb_loader and uuu are unchanged: every new check sits behind
sdp_is_closed().

There is no sandbox UDC, and the closed paths need fused hardware, so
the series was checked by building the SPL SDP boards before and after
it with the toolchain CI uses (gcc 14.2), with and without the part's
secure boot option:

  defconfig        secure boot   SPL bytes before -> after
  imx6dl_mamoj     IMX_HAB (*)          58800 -> 59088
  apalis_imx6      -                    46928 -> 47224
  apalis_imx6      IMX_HAB              49864 -> 50208
  colibri_imx6     -                    43280 -> 43576
  colibri_imx6     IMX_HAB              46248 -> 46560
  imx8mm_evk       -                   152448 -> 152400
  imx8mm_evk       IMX_HAB             155224 -> 155704
  verdin-imx8mm    -                   156336 -> 156288
  verdin-imx8mm    IMX_HAB             159112 -> 159576
  imx952_evk       -                   125248 -> 125696
  imx952_evk       AHAB_BOOT           129088 -> 129520
  qcom_sdm845_spl  -                   242032 -> 242192

  (*) in its defconfig

All build without new warnings, and imx6dl_mamoj, apalis_imx6,
imx8mm_evk and imx952_evk build at patches 4 and 5 too. The SPL links
the weak sdp_is_closed() without the option and the i.MX one with it;
on the imx8mm boards, where LTO inlines it, the SDP code calls
imx_hab_is_enabled() only with IMX_HAB. The tightest are imx6dl_mamoj,
whose u-boot-spl.bin grows from 61017 to 61305 bytes against its limit
of 61344, and verdin-imx8mm with IMX_HAB, which keeps 168 bytes of its
SPL's on-chip RAM, from 632; this is also why the refusals print
nothing.

checkpatch flags the two #if in patch 6: they guard gd members that
only exist under those options, so IS_ENABLED() cannot replace them.

CI: the series passes all 91 jobs of U-Boot's Azure pipeline, in build
13725 of my CI-only pull request, on main e43c38e0021.
PR:    https://github.com/u-boot/u-boot/pull/1064
Build: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13725

Ana Bobillo (6):
  usb: gadget: composite: bound ep0 requests to the request buffer
  usb: gadget: f_sdp: drop an empty data packet
  usb: gadget: f_sdp: write report 2 data only within a download
  usb: gadget: f_sdp: decode the command's address and count once
  usb: gadget: f_sdp: report a closed part as the boot ROM does
  usb: gadget: f_sdp: refuse unauthenticated loads on a closed part

 arch/arm/mach-imx/ele_ahab.c   |  13 +++
 arch/arm/mach-imx/hab.c        |   7 ++
 drivers/usb/gadget/composite.c |  16 +++
 drivers/usb/gadget/f_sdp.c     | 175 +++++++++++++++++++++++++++++----
 include/sdp.h                  |  19 ++++
 5 files changed, 212 insertions(+), 18 deletions(-)


base-commit: e43c38e00218eae1a7b4a683c0fef8973d838fa3
