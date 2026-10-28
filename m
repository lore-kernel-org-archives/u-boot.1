Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ABE606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hiUclQWw;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=J3hPHyQ/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2702E80DBC;
	Wed, 28 Oct 2026 14:45:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N0iDFWK6mt0u; Wed, 28 Oct 2026 14:45:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6303F80DD1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198751;
	b=irwrvsdiC6aw2901oxvA7JK0FS3fFO4B+eN+XuLcNDpdeZXQRe0KsDa+W69LIWUoBGFi
	 jA8Zw1H8bppxvBD6SwCLJxVDA/zPP7/ua9RhlaxF7h/ws7FyAZRSs5pVjOhQIUguvWHFM
	 Tp7dGxVn23wCN2Ml9EAcf2ipt2pLX5UStF2iY8KGJfZOYUUwLsBYgYaR1FNbIpDBDyjkX
	 y+0hR9WVyAsdzmJ36on/rgFQIWP76JMl01ms+YgWNPVyiofOqxThyoshMExQBuF/y2pNp
	 9a8dgZ83/Q373VKsktKUXNgvwyOdbkxpDc0pfq1lghnjjYXl3hopZXoalVbzHHsro8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198751;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MxzMMGvpFsLOAzZaacMK4dHOp0DGhZ0DFykOadKAyeU=;
	b=F7HY9VcBWmrmv3jf1QIzINC9y2sv7xfVDnG4xNjDN1UhgGzjLZ5Y5zTeOzKoHDzDl9H4
	 c3P6/PhANVmtsbHH/7y4PD1c6+A06Gd9kM5o+me40/iWQlXbZ4eYJgA8VOOvmj5novAqD
	 TfaMrEMo7j8ELvQIsFZbDXuyWyap3Y7mVElLD+ZT9lOcSS6MjHcT+HAv0AQVaS6rtPHi8
	 vx+xT/tkNVelzo26npaw8ROl7BH/QBuJu29u7SXv476IjkED4j8VCLw+O1xVpSQgzWhX8
	 CmvA9b+2awR9YrCvAPp81rUPCZU8kOW+AaCBX1+cDrFq4jEC2G/DkQ3ZDubbZoHi7nQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="J3hPHyQ/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198751;
	bh=MxzMMGvpFsLOAzZaacMK4dHOp0DGhZ0DFykOadKAyeU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hiUclQWw1P4d/qPSYCu2dA8WyAd6E+lY48HmO4r+NogDKLxGRmHr6OzLMANzaHFoL
	 X5/ep1dCkjakqIngdFX1DAS2Ximo9omSuFz5CHt90YyZItw/Ig9VnBb56WF4SIfMMd
	 xtZdqC0lrxccmcfiZWyK9Cf2difdVmiHQPfEpQGkuBQGlZxfidgd6jS/ibawoxMNME
	 4SXDQyTAfbBs17WIZ6xiqyihXx/0N/ghrrL3E9OBnsSbjx1RE1BbGqR1SEIINLjsjA
	 1R4Ui8VLnR/Wr8AegfFD4BAkTqvgCYkTACjM1mb/s5ltOWXOL5di2Xwzoe8mK8KD+y
	 YX/VY8oy3m7Lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6303F80DD1;
	Wed, 28 Oct 2026 14:45:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B651972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:09:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3BC2E80BCD
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:09:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4vyokSwZSfMq for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:09:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C9B9480BA6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::636"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196590;
 b=s9tHpbq3xzrAooUDk08Gq6dvauZcHXEsbPuqAazZDCT7I6/p9LPVsBo+QWFxnTYNQ3xA
 f8+p3fazLcMjHF5P+bbG20PezKlOCzdlMaxeysqw/cI711UMIPZwcvPIha0rHnnqMQXUZ
 1zCG5a/bsWYep/9F810nE3k0imGegkpbxtuZG+LaTHNMHO+HL7qdr+fVnEP5gohH0Lh7D
 qd6fcSrNe4PSiCbT5NclYenzRyfk5j8MuKtGuZjq9mieBxVfIC18NkEbNqCpgAVPPbZHj
 iRKtvDaVu00VlCdRzlbPCRMAd/iRp79x+ZElaeG27aSBx6ef+O1vtG0G896Hml9dxOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196590;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=MxzMMGvpFsLOAzZaacMK4dHOp0DGhZ0DFykOadKAyeU=;
 b=SJfEqC8I3fbVFEUCXTKd2036a3BegEEyvCU5KVRVAfE+7LzvL+Cq4RQfB6dW6RM5bueY
 NzxSQOMQBnwU0O6dZDvyPreYh2eZ2GSBHAQDPy2gFE4uulq5RtDvPtj37kzoMcdK3/SMK
 V3Wi6gMuRCK4L/T9mXspIlml0SUd/iY0/maNTsl9oqhMCp/fR8zmssr8ZxdeCgdjerCeN
 dLlzUbJVR7m+5+4EFn0CbuWKNA7Y6zYEVAQVXiV5ehhRfMPItyE4NgBhRoNRHpfEvlU7P
 bx1RLDpAmuSrTXsfC7eCpJyS1Ptxt7y9VFS89lpSgVeFRqbxS9r7+VPyfxh2ZUQp2Ag==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="J3hPHyQ/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=J3hPHyQ/
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C9B9480BA6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:09:48 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c4015fb0b42so10355466b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196587; x=1793801387;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MxzMMGvpFsLOAzZaacMK4dHOp0DGhZ0DFykOadKAyeU=;
 b=J3hPHyQ/ENIs2aZE+w3YhqzwKyoAPApZFaObFnZfaS2JF4Etd5nlKZ5qqocZKCa6rf
 n4ov627D3XtQHOE5OR9JCPPaa10WyApYChxAbSb1tt7n7rexJugzP2Vk6LzVviSwPuiJ
 7S//y6TSL4depFL71uUMB0LEFt7n9doWr0UhTb/ce398oe16wXB8/p8uwpg1ivKWSDSj
 avGkD6DI2yTd/yIEChNCGG13iBdPT7MxrmhH3w48nGrUWOxCgT88Sv88PN22qQ+anTLM
 a87nQhikckwJoG4IFtyqg8Q5StLSl4XQJLjAUgyVojo/TBVVAUW8Ag5/+eO3+ECoDJW+
 0tTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196587; x=1793801387;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MxzMMGvpFsLOAzZaacMK4dHOp0DGhZ0DFykOadKAyeU=;
 b=dVwkkoTbC59I40FHU3tVvLtwZ6H5K0EX65iFJjN1y5ZyKVy0OqFg1MSdwtwCN1Per5
 XTODeQ2MOoa3ojZLyaxpgtnba8cT+5wnnd3+22GPEV6YNeqqJ+4Yz8XEM4/WWG7wEeHv
 Mi+WRPcOyVpdK7OsQ9GSwjcOQxt8Q0SjFJ38vM5QfN0SHKriRHM0tPfqdnGmbkeMPJZM
 Wm2PeFxlwbE4vTntn2gwsgkHhFQy4ZSkaEMlEOorM698H8XxNASPHtCgUxi91/ah4Nc9
 frBza0t/RmPr4OUp8a4WHLGpEYAPgwO15NugWNIPY80rV5GADOPcOFvXaeEOJO1fh9tZ
 eDYg==
X-Gm-Message-State: AFq9FYJfcj7JM3Eav8l0GwlrvuLDrhSmIZ8tCx9g4Hae+b8GKqPaQGWG
 F1R8lKiBSGpThdRbh7yUFOZo6YIVWz3KifxrPRHNR+4zHDNOtNMPEnAnQSOOt5GEJAG4LFWV2V4
 EY045
X-Gm-Gg: AYBFou2dU9V33TMCNl0iRm1pvSZ5Nl7/2IQmZ0UPLWqerwFd83UCw71NcD4Upq8uvp7
 XfNkl0TaKnQNtmboP+KuAWWWtQMaDJoCrbf6NBnGaIft+wKdCxWGg/RGWagLG2j66Mh3AuwnLmg
 vi5o+ouKRzcSjTJSSbXBDVseXpjmB/9hXDkDeBU8oPRbR/SLMaOIEhBcMCs5h82A0Z/EPaZ0K1z
 y0XdUrRGo88MsQCurb2xT961VYMtWdfUoDzhfNpLO6vxP78zPBCbcB1bY5LEGwqj4RWAZ5AAift
 8C/CqL7yFe2dbzMjQgWJbBLI1gVhcxVxYLvRAElgpgyqqskjOzyxTjfSDLP08+JovfWvxkN1/mI
 dEYlWu0XStEGrt+Hn0Qms+mavpROUMCSexqjxT49dXPoOjWlRJWQ3KNgm3993K4F0hP6mSRmIQ/
 6/G7v65ICr9LB47OGjDcSf21RfZLFpVHmEzs9GXOt2BHxBU8Eo3Q6NXdRfk+HoI3KRtBldBJO3X
 NnwsLVx/5CCSZQp7BZNOgNtTQsLK1Ka9eaB+d78gPSqlbUY1Vll68gE/RnMMwtJtYf3zWWfGOaZ
 o6mWbqkGThJw20uVHHcfNJYJOmicMEROqInXDLDhrPAE96eu/i4j2N4TNcKb2NJpso3uOgZWzFf
 B+xO8hghmbAc=
X-Received: by 2002:a17:906:b30c:b0:c3f:98d4:dfda with SMTP id
 a640c23a62f3a-c49bde860a4mr225419566b.3.1793196586878; 
 Wed, 28 Oct 2026 07:09:46 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd790afasm607807266b.68.2026.10.28.07.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:09:46 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 00/63] usb: dwc3: part 1, reset and import from Linux v6.16
Date: Wed, 28 Oct 2026 15:08:26 +0100
Message-ID: <20261028140930.3025368-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:46 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This is part one of two. It resets the DWC3 driver and imports it up to
Linux v6.16. Part two [2] follows right after this one and makes the
tree build and work again.

Part one on its own breaks the build for every board that enables DWC3,
and USB gadget stops working. That is expected. The two parts have to go
in together.

Part two lists the boards that were tested on hardware, with both parts
applied.

The driver was forked from the kernel v3.19-rc1 eleven years ago, in
commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel to
u-boot"). After that almost no kernel changes came back to U-Boot.

Part one is three steps:

1. Re-import xhci-ext-caps.h from v6.16. Marek asked for this one to come
   first, since the dwc3 imports build on it.

2. Restore drivers/usb/dwc3 to the v3.19-rc1 import. U-Boot only files
   like dwc3-generic.c and samsung_usb_phy.c stay.

3. Import the dwc3 directory once per major kernel version, from v3.19
   up to v6.16. Each commit is a raw snapshot from that kernel. The last
   two patches re-import epautoconf.c and udc-core.c the same way.

The import commits are raw kernel snapshots. This is on purpose. It
makes it easy to see what comes from which kernel version, and to
compare each import with the matching kernel release. The commit
messages say this too.

The branch has both parts [1].

[1] https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v10
[2] part two, subject: [PATCH v10 00/30] usb: dwc3: part 2, make the
    resynced code work
[3] v7 part one: https://lore.kernel.org/u-boot/20260824152734.159794-1-anders.roxell@linaro.org/
[4] Marek on v9 part two: https://lore.kernel.org/u-boot/4b24f045-7fa1-4be0-8993-2bd441a7e716@mailbox.org/

v7 -> v10:
- Skipped v8 and v9, so both parts have the same version.
- Rebased on 8649a54d301a, since v7 did not apply anymore. The restore
  commit conflicted on dwc3-am62.c after commit 83abf9120071 ("usb:
  dwc3-am62: check dev_remap_addr_index() for NULL"). It still deletes
  the file, and part two brings the fix back.
- The restore commit keeps samsung_usb_phy.c now, instead of a patch in
  part two that brought it back. It is U-Boot code and was never part
  of the kernel import. Marek asked for this [4]. I kept Mattijs'
  Reviewed-by, since the commit only deletes one file less.
- The other 62 patches are unchanged.

Older changes are listed in v7 [3].

Cheers,
Anders

Jens Wiklander (60):
  usb: dwc3: restore to original v3.19-rc1 kernel import
  usb: dwc3: import from kernel v3.19
  usb: dwc3: import from kernel v4.0
  usb: dwc3: import from kernel v4.1
  usb: dwc3: import from kernel v4.2
  usb: dwc3: import from kernel v4.3
  usb: dwc3: import from kernel v4.4
  usb: dwc3: import from kernel v4.5
  usb: dwc3: import from kernel v4.6
  usb: dwc3: import from kernel v4.7
  usb: dwc3: import from kernel v4.8
  usb: dwc3: import from kernel v4.9
  usb: dwc3: import from kernel v4.10
  usb: dwc3: import from kernel v4.11
  usb: dwc3: import from kernel v4.12
  usb: dwc3: import from kernel v4.13
  usb: dwc3: import from kernel v4.14
  usb: dwc3: import from kernel v4.15
  usb: dwc3: import from kernel v4.16
  usb: dwc3: import from kernel v4.17
  usb: dwc3: import from kernel v4.18
  usb: dwc3: import from kernel v4.19
  usb: dwc3: import from kernel v4.20
  usb: dwc3: import from kernel v5.0
  usb: dwc3: import from kernel v5.1
  usb: dwc3: import from kernel v5.2
  usb: dwc3: import from kernel v5.3
  usb: dwc3: import from kernel v5.4
  usb: dwc3: import from kernel v5.5
  usb: dwc3: import from kernel v5.6
  usb: dwc3: import from kernel v5.7
  usb: dwc3: import from kernel v5.8
  usb: dwc3: import from kernel v5.9
  usb: dwc3: import from kernel v5.10
  usb: dwc3: import from kernel v5.11
  usb: dwc3: import from kernel v5.12
  usb: dwc3: import from kernel v5.13
  usb: dwc3: import from kernel v5.14
  usb: dwc3: import from kernel v5.15
  usb: dwc3: import from kernel v5.16
  usb: dwc3: import from kernel v5.17
  usb: dwc3: import from kernel v5.18
  usb: dwc3: import from kernel v5.19
  usb: dwc3: import from kernel v6.0
  usb: dwc3: import from kernel v6.1
  usb: dwc3: import from kernel v6.2
  usb: dwc3: import from kernel v6.3
  usb: dwc3: import from kernel v6.4
  usb: dwc3: import from kernel v6.5
  usb: dwc3: import from kernel v6.6
  usb: dwc3: import from kernel v6.7
  usb: dwc3: import from kernel v6.8
  usb: dwc3: import from kernel v6.9
  usb: dwc3: import from kernel v6.10
  usb: dwc3: import from kernel v6.11
  usb: dwc3: import from kernel v6.12
  usb: dwc3: import from kernel v6.13
  usb: dwc3: import from kernel v6.14
  usb: dwc3: import from kernel v6.15
  usb: dwc3: import from kernel v6.16

Jerome Forissier (3):
  usb: host: re-import xhci-ext-caps.h from kernel v6.16
  usb: gadget: re-import epautoconf.c from kernel v6.16
  usb: udc: re-import udc-core.c from kernel v6.16

 drivers/usb/dwc3/core.c           | 2961 +++++++++++++-----
 drivers/usb/dwc3/core.h           | 1087 +++++--
 drivers/usb/dwc3/debug.h          |  432 +++
 drivers/usb/dwc3/dwc3-am62.c      |  424 ++-
 drivers/usb/dwc3/ep0.c            |  763 +++--
 drivers/usb/dwc3/gadget.c         | 4776 +++++++++++++++++++++--------
 drivers/usb/dwc3/gadget.h         |  114 +-
 drivers/usb/dwc3/glue.h           |   36 +
 drivers/usb/dwc3/io.h             |   51 +-
 drivers/usb/dwc3/linux-compat.h   |   16 -
 drivers/usb/gadget/epautoconf.c   |  292 +-
 drivers/usb/gadget/udc/udc-core.c | 1890 ++++++++++--
 drivers/usb/host/xhci-ext-caps.h  |  158 +
 13 files changed, 9864 insertions(+), 3136 deletions(-)
 create mode 100644 drivers/usb/dwc3/debug.h
 create mode 100644 drivers/usb/dwc3/glue.h
 delete mode 100644 drivers/usb/dwc3/linux-compat.h
 create mode 100644 drivers/usb/host/xhci-ext-caps.h

-- 
2.53.0

