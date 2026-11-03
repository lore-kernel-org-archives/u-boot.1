Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA86606A327
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Lb7fdGS9;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=D+17oPl2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59AE760852;
	Tue,  3 Nov 2026 13:05:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u4HnbRKHqkFa; Tue,  3 Nov 2026 13:05:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 44A4B60825
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711116;
	b=G6m0XCpVParbp6y5qBM/1hcZu/33zqHOaGGmzwB2nkPoilZC9sHaFatHwuo7pLeJkZOV
	 35Mkfc/KDbRluUaFTe3tUWxf24zDetIvjUpyFXCbPTX2BMO0lzuk1IKcGLfIT58T7DATg
	 AFr8hi49g/wZZeLAQ2dy4Sc2HxVPv5rJEczRWcZgGYl3W+xvyIkiNutTnhbs/5hsga8E9
	 0FsKHSD7rM+/qCfR6kymQassNkLETOfBLnKHgAdj/16QAGWKV5Z31guj5KE6BDX6FWRRl
	 4KoAmXmxjtk1TqvhndDakln3qCOaAGecFPGwM4T2tR8iKhMeap34Ko3vnPACX4MBptA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711116;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jLLFsDK+dzoQ4SlExo/BtWLV3gcbNGry0ladcclBR7I=;
	b=bmqcH0qDltxMXr65WCatsjnHEv6CcRGtdcq/ufh7Xn9wlqFM8LZ1m9Yi00CoOleIy2Fs
	 Lbv9kJhagDSYXMJLysWbrGy+w4XK21Ii0Ge0P3HolLzCYpEA3M3Aak3Y+FfQRZVVbF2fG
	 4/u7jVvfGX1C1ajJ5VK76XnawTbH8RhuuadkxyPz77PFo7K1xtAznIX0sW7pHeyjvVtsH
	 75w8DMJg4R5WTxWAIuSj8Em/wV78pTkQiNzzctyvh7fnQgHBB4aL/4VKMSv2C4nbYfIaJ
	 lGM73xnKsxyNgOFASWyeDJPsI9+KQF5SCIbCvOnPpzMW+z8k0o83Y/YU+PZNaXBB4hQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711116;
	bh=jLLFsDK+dzoQ4SlExo/BtWLV3gcbNGry0ladcclBR7I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lb7fdGS9Il59XLd16z4XPG/UgQGAobCgcJHuQppanC0TP8Kmm6H+dJ7SuDqz2pInw
	 m4v2D2XMBG/OvTCBUcJAvIqjymm5Q8MdGYTwRYgYffUzADldnR5ifWjbnJPQx6ZG3l
	 OCjpbZJZgpSXtoVpI3BTibjqPmDl5cHg8eYSzFjsSBN4Lh2scfEys3Mk2ROvecLabP
	 nCu82XAifkOUhHu7oeWLNRwZQNwpWNJc903pk1K9yjeY6yfbxWlqoaAHWCwnRzdkLa
	 c/GNK9uAcMGdQcFhsPkHY1+1WndkJOkaBXu12RX6qSsPhokxKHhTA4OKy6+GmStRkv
	 MtkqopEmEq8lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44A4B60825;
	Tue,  3 Nov 2026 13:05:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CC56E11CA
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B2E22405CD
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nrBYq_ai-y_6 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:58:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 734F8405A7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699923;
 b=haEdVstGJpmWaXQbVu/L05n2R2jY5UwIzIgHXCGNFogataUuJTl+OCklkZJ7016KPojV
 D+e2X0XXO1vGAcsDND0SiXMl/RaYkIxQ3RknNI4GsjZVl8+EO/C4y0BJSx+K0t191r/nQ
 JTTz33NJA3M0kMG6DNn3idk1DjG7OMRaN4roieu33xcnhtvYrTiL04249mDQG0sNpxIoU
 1dfr1TQEDCrhgzGTtzT3h7bAZ0uo5hCLsg85sWR/nloUe+b7eNeCU2OF/pS37KUmq2VgI
 UNnRf/XubyCxcg50HCUDGIAm4AmKfpt0VFAO5DZfeQRpJ0XCBbFpSmQq732XXpPcVuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699923;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=jLLFsDK+dzoQ4SlExo/BtWLV3gcbNGry0ladcclBR7I=;
 b=mdYmxobDLss3kEHCa3PovUxGVZA0+QpD6LXDdepxF8d9vmFLdpbvRZYSfeU4gNc44tWX
 tli9JOaGmla0OvIJxSMi1+d8zGb8+Uzw1Gwrct/u08hBLgcPRSK6awgj90x3bBBm6wKLB
 wrkgeUrjk22TPcOnk6iQTSpyU11EXmHy9gXSDpGT81R1Xy11vW3R7JW5GJPHNrTPtFD2w
 OaCDID8rJ2dlNEDLmXr/2cYN1GVNZxJnT7N6wVO4pgLA0qI9aRWNW2BgFzNB4jEO22KHV
 EybHpfJL2SRuxKxHcGchHQcQ0IrqhlN6Vh2BnzralE6on1vOAHaPeN54C3W9hsH55qQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=D+17oPl2; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=D+17oPl2
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 734F8405A7
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:42 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so38295135e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699921; x=1794304721;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jLLFsDK+dzoQ4SlExo/BtWLV3gcbNGry0ladcclBR7I=;
 b=D+17oPl2yeBmCNhI6qZjx2LwWH5HQAzvDKCx2hxSBtzq2ED1hSeRBBZ2k0IXewgDC5
 euzEaAReH1eIq67AVsCyR+lekfW4EnN3MsXwwE5UrIu99/Lvs9owdOVhVaUr6dpr8uLP
 xcJvQaKsxEPsMN0YABHHCRN7TOD0W6pDAzx1Adxiuumycu0K9XP6T1h4furh24wYddkt
 li0tZ3ykbLiU2nDZZ3Rl8xGbptDRxS5M9Lw+5e4znj9SEJYV7l6eMppYfac/2Uczzqa5
 cWbaIx7ch8gTOWxV2AQO1y7HxoyrZKc8DAklC0+8IkALRXYv4k6Rqn5Lg3dZ6kAhV0tR
 +GOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699921; x=1794304721;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jLLFsDK+dzoQ4SlExo/BtWLV3gcbNGry0ladcclBR7I=;
 b=JeTiHYnUD5HNu+PiM6mRwKJNr1FFoaAX8GYvtjpLhzoKXM/+XgrFdxQ9BxvNf8M7uV
 K3l/6OlqUKGDVjS8fy0hy4Ke8fE6tKwjeh3OAWwiCwKpcUxSWyfJQ7JHPLile/m3vNhV
 MYu/ykaCcBc/izsmu7AmKl0ckZSEv70US4QjCeNw+xWp+3sz6WTDVYmF3q/wHfzOTCxQ
 vfjKfny7leX/W5LJyQqkbBryz6Alkp/yQYdTkF2Lwcql/T/vhBPGJcMuLD/34oGGJXYG
 PjHj9Y3sTgD2NUptQYvBDJF6JP3O5iy+LMeIovkjMDQoLYrffZMeYl4QK4qf3r9VFXJf
 z51g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRMzAeGgbqb6pRShRbTuUpPCK1PCYamxnPgjMA4hSFhuLitZejYoLZQBDOAFC4jCos3XNRFr0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+Fo6C5OgqSOiX/CZ6aER0kMckGz4vRAR/cDATbcBq1e56lakLC
 PEnVUTcJ2M2ABH/O6qZygVA5piYot3tcTRvm/2AK7ZXEWFXc1A5LYnkD9Idr04DLrYI=
X-Gm-Gg: AYBFou1XxQOe3AOfLVIHTg1B5CoV/e4THyw52oPw3lanm0kaKaqJhzwYs/YN9tyI6nt
 0CwnGCi69f6salHVS7geugaU/YzyaPySHXkriRRRt1ak96WzDlven6XKlhnCD4Gc3v3aFPxuo1I
 QwiNHfavOy3ncy78QHJ8ld4XlMgQta59aWwGyRUXHuDzd7wvSxR6+RYmBd3A8RPZ1l475HIM7OW
 Fa0yByBAaAwlTee4LMHNGafEynBbQAKKXbNoz1bmVM6fCuhKxr9lxBQwpLpTS33T6zIVia0p1/9
 cK8nZvSBAalWoIo7IpAriZBHgHCRaDDShBa9P8dBRYEqqz0tJbqnYq3OCuY2h50MM1YLir1nqfV
 ubDysES6kmMyFQwUOc1OgCW/8dhxHNkx+zNeOc0+elQvZEyZFEhqTc+xw+RJRj+KqiZ4HhFpmVw
 2UiwLAHi/2kWa+FWhDiBAJ8+9hKDmfCT67s2NDyzFNqwBz8w5DQylpH/9LwxDF/WHsSNDTlcoN8
 BDmUUXGiWMOA7IS4MfVRLvoGM9QwKBwVSzztIJY8xzMV3An7dB67IDEkeudbXHpuSYNd8AkUlm5
 /H/AOjijlfsjlV61V17cCXYhww==
X-Received: by 2002:a05:600c:19d1:b0:4a2:677:ad8e with SMTP id
 5b1f17b1804b1-4ac1970b9f7mr280115965e9.34.1793699920982; 
 Tue, 03 Nov 2026 01:58:40 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b7815fsm24802258f8f.22.2026.11.03.01.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:58:40 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:55:55 +0100
Subject: [PATCH v10 09/24] arm64: dts: ti: k3-am62*: Add wkup R5F nodes to
 pre-ram bootphase
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-9-0b24ff0a4d6e@baylibre.com>
References: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
In-Reply-To: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 u-boot@lists.u-boot-project.org
Cc: Kevin Hilman <khilman@baylibre.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Stefano Radaelli <stefano.r@variscite.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Bin Liu <b-liu@ti.com>, u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5351; i=msp@baylibre.com;
 h=from:subject:message-id; bh=lUq1C9KUvGquyhSg0ZYp0dIRsowBYb3w8HnD2LOs3kA=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyX61/V/k74PK+yUjTGeTPrD8E91Q+zlaVa7UU9rR4vF
 Htr+2RLRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEzk4ixGhu49OxgTVMOuvVsX
 Z75zb+U+7/ubelKNns/dtbn18ULTU18ZGaav8UxcxF5+xuDWrQPaS6b8tmab8YVjXl7drdls6z8
 bifIDAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For IO+DDR the wkup_r5fss0_core0 and the
wkup_r5fss0_core0_lpm_metadata_region need to be accessed before RAM
setup is done. These are used to read the lpm metadata region in
which data is stored to resume. This needs to be done before RAM is
in use to avoid overwriting data.

Add the bootph-pre-ram flag to the wkup_r5fss0_core0 node in both
ipc-firmware dtsi files and to the lpm metadata region nodes of the
AM62A and AM62P boards.

The board level bootph-pre-ram flag of k3-am62d2-evm.dts becomes
redundant with the dtsi-wide flag and is dropped.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
Reviewed-by: Stefano Radaelli <stefano.r@variscite.com>
Link: https://patch.msgid.link/20260918-topic-am62a-ioddr-dt-v6-19-v9-9-40972ef1f663@baylibre.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: 0d14dd104de66eff1500dec9e80d72c4ab82b608 ]

(cherry picked from commit 188c24904c518768b4d695761b4b1d2c39ffde39)
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi     | 1 +
 dts/upstream/src/arm64/ti/k3-am62a-ti-ipc-firmware.dtsi | 1 +
 dts/upstream/src/arm64/ti/k3-am62a7-sk.dts              | 1 +
 dts/upstream/src/arm64/ti/k3-am62d2-evm.dts             | 4 ----
 dts/upstream/src/arm64/ti/k3-am62p-ti-ipc-firmware.dtsi | 1 +
 dts/upstream/src/arm64/ti/k3-am62p-verdin.dtsi          | 1 +
 dts/upstream/src/arm64/ti/k3-am62p5-sk.dts              | 1 +
 dts/upstream/src/arm64/ti/k3-am62p5-var-som.dtsi        | 1 +
 8 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi b/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi
index 7fa19ced1a23..12be777a35ca 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi
@@ -80,6 +80,7 @@
 		wkup_r5fss0_core0_lpm_metadata_region: memory@9ca08000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0x9ca08000 0x00 0x1000>;
+			bootph-pre-ram;
 			no-map;
 		};
 
diff --git a/dts/upstream/src/arm64/ti/k3-am62a-ti-ipc-firmware.dtsi b/dts/upstream/src/arm64/ti/k3-am62a-ti-ipc-firmware.dtsi
index 94c1d60d8d7a..7beca54e75ee 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a-ti-ipc-firmware.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62a-ti-ipc-firmware.dtsi
@@ -63,6 +63,7 @@
 };
 
 &wkup_r5fss0_core0 {
+	bootph-pre-ram;
 	mboxes = <&mailbox0_cluster0>, <&mbox_r5_0>;
 	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
 			<&wkup_r5fss0_core0_ipc_region>,
diff --git a/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts b/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
index 871ec227def9..fe75f6b6b50b 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
@@ -74,6 +74,7 @@
 		wkup_r5fss0_core0_lpm_metadata_region: memory@9ca08000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0x9ca08000 0x00 0x1000>;
+			bootph-pre-ram;
 			no-map;
 		};
 
diff --git a/dts/upstream/src/arm64/ti/k3-am62d2-evm.dts b/dts/upstream/src/arm64/ti/k3-am62d2-evm.dts
index 7cba3ff99e6a..f87d6d515e2b 100644
--- a/dts/upstream/src/arm64/ti/k3-am62d2-evm.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62d2-evm.dts
@@ -800,10 +800,6 @@
 	};
 };
 
-&wkup_r5fss0_core0 {
-	bootph-pre-ram;
-};
-
 &mcu_r5fss0_core0 {
 	firmware-name = "am62d-mcu-r5f0_0-fw";
 };
diff --git a/dts/upstream/src/arm64/ti/k3-am62p-ti-ipc-firmware.dtsi b/dts/upstream/src/arm64/ti/k3-am62p-ti-ipc-firmware.dtsi
index 84dfbfd1986c..277d7e268cfe 100644
--- a/dts/upstream/src/arm64/ti/k3-am62p-ti-ipc-firmware.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62p-ti-ipc-firmware.dtsi
@@ -42,6 +42,7 @@
 };
 
 &wkup_r5fss0_core0 {
+	bootph-pre-ram;
 	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
 	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
 			<&wkup_r5fss0_core0_ipc_region>,
diff --git a/dts/upstream/src/arm64/ti/k3-am62p-verdin.dtsi b/dts/upstream/src/arm64/ti/k3-am62p-verdin.dtsi
index 45ab9d947b3a..62a518dbbdbe 100644
--- a/dts/upstream/src/arm64/ti/k3-am62p-verdin.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62p-verdin.dtsi
@@ -183,6 +183,7 @@
 		wkup_r5fss0_core0_lpm_metadata_region: memory@9ca08000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0x9ca08000 0x00 0x1000>;
+			bootph-pre-ram;
 			no-map;
 		};
 
diff --git a/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts b/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
index bb027c65eddd..39af098e4db2 100644
--- a/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
@@ -70,6 +70,7 @@
 		wkup_r5fss0_core0_lpm_metadata_region: memory@9ca08000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0x9ca08000 0x00 0x1000>;
+			bootph-pre-ram;
 			no-map;
 		};
 
diff --git a/dts/upstream/src/arm64/ti/k3-am62p5-var-som.dtsi b/dts/upstream/src/arm64/ti/k3-am62p5-var-som.dtsi
index 31f670fdd91d..2eefbd8d47a4 100644
--- a/dts/upstream/src/arm64/ti/k3-am62p5-var-som.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62p5-var-som.dtsi
@@ -84,6 +84,7 @@
 		wkup_r5fss0_core0_lpm_metadata_region: r5f-memory@9ca08000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0x9ca08000 0x00 0x1000>;
+			bootph-pre-ram;
 			no-map;
 		};
 

-- 
2.55.0

