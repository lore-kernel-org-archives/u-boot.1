Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF297606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M2uXMO9V;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=cmjIIikP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1EA160871;
	Tue,  3 Nov 2026 13:05:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D1wDVcwnIg-U; Tue,  3 Nov 2026 13:05:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9FF6D6082E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711121;
	b=Ok0FIDiNDI+x4r57UaJJ4xTgAX+Wl7Sx0maJcg9EVhb0mH9gLTNgt80c2y4Tcw2Cyjiq
	 fIf72RpNOcQlrJR9yPsRmvrJJRYOIJGWyxnl0VPfA5ivzS+Fgi8MSzx79CLBwnnt5UvzJ
	 BaNoogkDdtzECXlFRixEEUGdrIPN2SInAKUeWRIjp2hJrswvEV48JWnW2Sll6TswNiwCd
	 GtHYrGEPaUjdNuDv7zVuEmxzHZog2gti/F/A4Z3bZzBptlsFe9x4W8AcN5mg94PaEtSKQ
	 5zinVRxf3yRk0z1+MwDxoXJuVS1koaTyaxJC8eRUlF0DzalLaIRjLNQCRi4tP+BeKbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711121;
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
	bh=2zm41P0siDZxKWTI5n0olmaNxbxMBGlxPyTz84bL6l4=;
	b=GP0/37VnKgWaH0McwomqDeBh3DaGB8NrancdfYVBIw+VbCfI7kr0cjzKi/GaWnERddP8
	 gFcOOraGofc1ncjtFd3oczx7eXwytLnueHQ3xK9gPuiKGn+ez3OxwwvZcl3JoTpY7iuK3
	 d/eLedUXjh43hgh8xStnJyGiclabGdiYZRDAitNKotZDNl205Hq4g6rdIDMvWjIZg5C/c
	 8Oo9uDl5wjVH81+YAGfgbDIhoYRsPm128D4uWrkCjpGSVEiRYHdTPRmdx0OhzZPoRPQ1C
	 xM4FakAVTEKO4frS9LGfLKZMB7kMRnJ4k+3FRLaJiWBAMVsr5P6ukbd2Bu882EOWm+Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=cmjIIikP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711121;
	bh=2zm41P0siDZxKWTI5n0olmaNxbxMBGlxPyTz84bL6l4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M2uXMO9VeyF6E40LPdWQ+DX1/YNx177EgpjCMcxCRf+Kxg1GJpmgXUk1yD9IIrJxM
	 K2ueWr/pd+zYoIX3Cggwv4hblvE85FopGxXWV7DC1CiWhWW/jxuUTrUVAYUdp2myKQ
	 C0M2OirftsXPuZVT3O+Iw/KSLoUG5fS7peNiR1OVLAqRAA0fhv7L5oLbgUqAAFUiy1
	 VCPJ+Fa98iM6NvYXtlXtZGF7/48HZ97cghOtqUtYGuMhJ93UVjGpm2W3FeGiDSbdm2
	 UnEvmPFDGLAB4yMnB8rf6x6raj5daIiHu8guqW6c5C3HPY9CRYu/xz6DUyf3/PS4zx
	 rLLh8rP25QUzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FF6D6082E;
	Tue,  3 Nov 2026 13:05:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F403356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 85C1760670
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tqfWvC5vw7U6 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:58:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 62FA0606A0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699928;
 b=fQNjYuNeuUVEJZ6vjtNJSZNH6BG6MG/3JTqo8R1gUHWaDv6LI5S6uTJoVLs2zWUc+cpE
 dQ/rZXqzTvL5paJCHk/Sq6DaiVE4pL8GSGBHf2aQObfoEnwLIU+zpxw34jYGe+D2qJ2kE
 rd5536xdfVl+PZjS4DJZoFVTP+tkUlp0NbTEVlzuxydci3QEue4O3y9Tk/Tt3BXBSpjwK
 8sh6ifxwRE1dsoMZhm60nPVJIMESFyCoYcu/lRRh0WUujGpTa1nuejoBAtxRSnSUSZXB8
 J7/gS+FU6Gt5cZBioCotZ+r++qAfZlALXgaCF1JwFSSDfRuFtDa5UIU/L7M9rm1ltAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699928;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=2zm41P0siDZxKWTI5n0olmaNxbxMBGlxPyTz84bL6l4=;
 b=iFRmfEXdtAmOdFVxDEYRNWdARkDIeQvt7Cm4G3voXU9fdp2ntuWfXROJ8EvWekMU6GUT
 bhYjD2cNOuv/6Ip9lTKF5inOZYD2BuCt3nKvx8tSN0NoIc0AoRg/6Lzfhu98NPMv7tjrM
 AlpUkbfMk51mLTvMwClxcBb03PuwpTqcoX6CGykmX0eLvmKgtmok/NqQQHfF5YRTO6727
 c2/NvAM830lKMR2H7K9p3rtSXC75hAcRIW2m471LTSzKvoJgd8u42apDhQ1ktqN4b/+pl
 LkmX2Tsc81S9ND/Gk/D+9nzZpC93zqtRRdynPhDW6goPRLTRfky0834hdb+MGEyppPw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=cmjIIikP; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=cmjIIikP
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 62FA0606A0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:47 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso44252685e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699926; x=1794304726;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2zm41P0siDZxKWTI5n0olmaNxbxMBGlxPyTz84bL6l4=;
 b=cmjIIikPG76VXLmSB0CeEGq0Nupl9o4CjFw0pGb9OpWmoaXLVRIkO42phqUWwh3zrh
 B95ZWI8MUyb47t4mMMngFDdu7LtFmW+5BTeYBRKbuXktZ9N2M2BQ0f3MidDEdVkvCYpq
 CGor1tj+XtNGQwjCqeImNUN3cyrxk2X4037IkLOQ26/inWmJjy/rn0WE7zV7SaFiO+uS
 EyzgegHXxudUMiQTDAJKegWaUyZBdg/Rtb4VjvtqABRHbwv4zjwJuhQsWmb3d+YP5JQS
 xfRblPQXS/XilbykAQzzCkfFYIy4qA1tLUkVls0lJdbCWBNu+nV2cN8+yIFeP/6dyR5c
 j0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699926; x=1794304726;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2zm41P0siDZxKWTI5n0olmaNxbxMBGlxPyTz84bL6l4=;
 b=BN+W16WsWrO9Yod00pXH98TKwjX29+6x2gb6yyG3eYHf33YmTIzSyctlF5DOgvc/bK
 pwSh93nbpc/oFjkBM0k7BEF34UsiNh2I+mHXozozBCJCnL2k3MxQpFLp4CK+invELULk
 Y/CHRGfvRV1DYVWsc6nznQ5uOoWv1DI02CE+poP/bx25lPcC0rmCoISjpSk+ROD9r1tS
 DyCAtBNs8+9rQiK9ObtTXGZP7Bua+lpq/1igN4SoCx4dFSv1OXX+EwqxtpuaUgxkV8v8
 VjwdNwOQQFUNWoTGdH/EktDL1o+n3c9aqVZHYmdhUdN8dXrWCRelRKN84GiFaXynaz3a
 0MGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlFLl1b76TTHA8qsm19hR+itKwxl+Zv5r60nKBiUU04B/7XpbB30emO5wGg4bPm3UlfM+hBgQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/Duo1uSYASPpiPoFhicrdy0DITaU9sIB5Q2uWIUYRwaUUd7P/W
 gsZu0GslfKHZa60cbJoYx3ZnHXo3g7tC7YZLbaa39GLamB93zTOxu/GVGY9r1hEtuec=
X-Gm-Gg: AYBFou0lYEtQZn8zTqBI4T6I9EitU7HlU9RIz98z0jRMzku3P4iWjGvVSaArEQV6fmn
 kaf5UNYUdJq3t2DNFdwGLO7lV3BRzDtWmA9EUv7Ef2jcClmDbq0J0ktyyMOx62+jJRrH05Bn8O9
 v+uhdF1i5Jx6xpRptT5Qrcc4ZKRBCYEky5wr3LQJFkCZeX/uWc4k3Mf2cZUHiqtYtHAu7mxo+hW
 bxsPSAhqktBnpMzKFzi0IWBq/myeAU9J+dpS9W0MZhRtsSLjWft1AZjwjR3sNIQxLf3qwRxbDsy
 oBkQ7gzHRC3HosxHid/lAeYLQge1Q37zLJwgga70OTokh2IdSptD2Qf4r66Wzvloq2loTLshRZZ
 l8jTyvYkuuHFmhd6IML2eyf7yZWdkQAc5MMjYKJN9u+XCUoD22CMeoIMp/3EJodjvoG2grdf1zv
 RPGcVD/YbJ2Fn6YHxfvVrfJxJjbvPMKnPzOZLeTG5571U0UIxx+t744kVckE3JzQYTTXid0EIvn
 afRjZYaEkYaMc3boZpnT6kESqyI/8sk2MTuyj+A6g0tD1iiC7lXbm4m692qr6wJqALnPM8G5+3n
 RkGjw/xwqxFWoOJm7CcY4CV4Eg==
X-Received: by 2002:a05:600c:6095:b0:4a3:7344:13b5 with SMTP id
 5b1f17b1804b1-4ac182dcb98mr252767485e9.16.1793699925705; 
 Tue, 03 Nov 2026 01:58:45 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a98e8f9fsm49988805e9.13.2026.11.03.01.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:58:45 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:55:58 +0100
Subject: [PATCH v10 12/24] arm: mach-k3: Remove CANUART IO isolation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-12-0b24ff0a4d6e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7748; i=msp@baylibre.com;
 h=from:subject:message-id; bh=JbVVD3fXacGCDTs11XlmIxGpiB9KqVi+dUaF09n+q5M=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyXGxgZee63GdhVPd3AurTv3rS/2X9KQw2ZnxxeYBF4b
 XMP/96tHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCReXsZGdaWC2/lO1fPqG3M
 tJ+h4N67BS9SA7bFs096lZb1/+v0o96MDJP1M9kmnbfkrHti9mfJxtOXmyU1+9YGeSytEN0Volb
 gwAYA
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

After leaving the Partial-IO mode or other deep sleep states, the IO
isolation needs to be removed. This routine is shared by at least am62,
am62a and am62p.

The original function for testing was developed by
Akashdeep Kaur <a-kaur@ti.com>

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/mach-k3/am62ax/am62a7_init.c |  5 +++
 arch/arm/mach-k3/am62px/am62p5_init.c |  5 +++
 arch/arm/mach-k3/am62x/am625_init.c   |  5 +++
 arch/arm/mach-k3/am62xx-lpm-common.c  | 85 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/am62xx-lpm-common.h  |  1 +
 5 files changed, 101 insertions(+)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index 0d86d52ef267..401d6a8e41fa 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -14,6 +14,7 @@
 
 #include "../sysfw-loader.h"
 #include "../common.h"
+#include "../am62xx-lpm-common.h"
 
 #define CTRLMMR_MCU_RST_CTRL             0x04518170
 #define RST_CTRL_ESM_ERROR_RST_EN_Z_MASK 0xFFFDFFFF
@@ -139,6 +140,10 @@ void board_init_f(ulong dummy)
 	/* Init DM early */
 	spl_early_init();
 
+	ret = wkup_ctrl_remove_can_io_isolation_if_set();
+	if (ret)
+		panic("Failed to remove can IO isolation when set %d\n", ret);
+
 	/*
 	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
 	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.
diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index 599ea7cf2dd8..2b7fc5f3315f 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -14,6 +14,7 @@
 
 #include "../sysfw-loader.h"
 #include "../common.h"
+#include "../am62xx-lpm-common.h"
 
 #define CTRLMMR_MCU_RST_CTRL             0x04518170
 #define RST_CTRL_ESM_ERROR_RST_EN_Z_MASK 0xFFFDFFFF
@@ -123,6 +124,10 @@ void board_init_f(ulong dummy)
 	if (ret)
 		panic("spl_early_init() failed: %d\n", ret);
 
+	ret = wkup_ctrl_remove_can_io_isolation_if_set();
+	if (ret)
+		panic("Failed to remove can IO isolation when set %d\n", ret);
+
 	/*
 	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
 	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.
diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
index decb50bf853d..fa7dcb7a6cce 100644
--- a/arch/arm/mach-k3/am62x/am625_init.c
+++ b/arch/arm/mach-k3/am62x/am625_init.c
@@ -15,6 +15,7 @@
 
 #include "../sysfw-loader.h"
 #include "../common.h"
+#include "../am62xx-lpm-common.h"
 
 #define RTC_BASE_ADDRESS		0x2b1f0000
 #define REG_K3RTC_S_CNT_LSW		(RTC_BASE_ADDRESS + 0x18)
@@ -163,6 +164,10 @@ void board_init_f(ulong dummy)
 	/* Init DM early */
 	spl_early_init();
 
+	ret = wkup_ctrl_remove_can_io_isolation_if_set();
+	if (ret)
+		panic("Failed to remove can IO isolation when set %d\n", ret);
+
 	/*
 	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
 	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.
diff --git a/arch/arm/mach-k3/am62xx-lpm-common.c b/arch/arm/mach-k3/am62xx-lpm-common.c
index 424d7457c596..54d86b0474df 100644
--- a/arch/arm/mach-k3/am62xx-lpm-common.c
+++ b/arch/arm/mach-k3/am62xx-lpm-common.c
@@ -9,15 +9,93 @@
 #include <config.h>
 #include <asm/arch/hardware.h>
 #include <asm/io.h>
+#include <wait_bit.h>
 
 #include "am62xx-lpm-common.h"
 
+/*
+ * Shared WKUP_CTRL_MMR0 definitions used to remove IO isolation
+ */
+#define WKUP_CTRL_MMR_PMCTRL_IO_0				0x18084
+#define WKUP_CTRL_MMR_PMCTRL_IO_0_ISOCLK_OVRD_0			BIT(0)
+#define WKUP_CTRL_MMR_PMCTRL_IO_0_ISOOVR_EXTEND_0		BIT(4)
+#define WKUP_CTRL_MMR_PMCTRL_IO_0_ISO_BYPASS_OVR_0		BIT(6)
+#define WKUP_CTRL_MMR_PMCTRL_IO_0_WUCLK_CTRL_0			BIT(8)
+#define WKUP_CTRL_MMR_PMCTRL_IO_0_GLOBAL_WUEN_0			BIT(16)
+#define WKUP_CTRL_MMR_PMCTRL_IO_0_IO_ISO_CTRL_0			BIT(24)
+#define WKUP_CTRL_MMR_PMCTRL_IO_0_WRITE_MASK ( \
+		WKUP_CTRL_MMR_PMCTRL_IO_0_ISOCLK_OVRD_0 |	\
+		WKUP_CTRL_MMR_PMCTRL_IO_0_ISOOVR_EXTEND_0 |	\
+		WKUP_CTRL_MMR_PMCTRL_IO_0_ISO_BYPASS_OVR_0 |	\
+		WKUP_CTRL_MMR_PMCTRL_IO_0_WUCLK_CTRL_0 |	\
+		WKUP_CTRL_MMR_PMCTRL_IO_0_GLOBAL_WUEN_0 |	\
+		WKUP_CTRL_MMR_PMCTRL_IO_0_IO_ISO_CTRL_0)
+
+#define WKUP_CTRL_MMR_PMCTRL_IO_GLB				0x1809c
+#define WKUP_CTRL_MMR_DEEPSLEEP_CTRL				0x18160
+
+#define WKUP_CTRL_MMR_CANUART_WAKE_CTRL				0x18300
+#define WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW			0x2aaaaaaa
+#define WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_SHIFT		1
+#define WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LOAD_EN		BIT(0)
+
 #define WKUP_CTRL_MMR_CANUART_WAKE_STAT1			0x1830c
 #define WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE	BIT(0)
 
 #define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT		0x18318
 #define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
 
+#define CLKSTOP_TRANSITION_TIMEOUT_MS	10
+
+static int wkup_ctrl_remove_can_io_isolation(void)
+{
+	const void *wait_reg = (const void *)(WKUP_CTRL_MMR0_BASE +
+					      WKUP_CTRL_MMR_CANUART_WAKE_STAT1);
+	int ret;
+	u32 reg = 0;
+
+	/* Program magic word */
+	reg = readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_CTRL);
+	reg |= WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW << WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_SHIFT;
+	writel(reg, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_CTRL);
+
+	/* Set enable bit. */
+	reg |= WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LOAD_EN;
+	writel(reg, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_CTRL);
+
+	/* Clear enable bit. */
+	reg &= ~WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LOAD_EN;
+	writel(reg, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_CTRL);
+
+	/* wait for CAN_ONLY_IO signal to be 0 */
+	ret = wait_for_bit_32(wait_reg,
+			      WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE,
+			      false,
+			      CLKSTOP_TRANSITION_TIMEOUT_MS,
+			      false);
+	if (ret < 0)
+		return ret;
+
+	/* Reset magic word */
+	writel(0, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_CTRL);
+
+	/* Remove WKUP IO isolation */
+	reg = readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_PMCTRL_IO_0);
+	reg = reg & WKUP_CTRL_MMR_PMCTRL_IO_0_WRITE_MASK & ~WKUP_CTRL_MMR_PMCTRL_IO_0_GLOBAL_WUEN_0;
+	writel(reg, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_PMCTRL_IO_0);
+
+	/* clear global IO isolation */
+	reg = readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_PMCTRL_IO_0);
+	reg = reg & WKUP_CTRL_MMR_PMCTRL_IO_0_WRITE_MASK & ~WKUP_CTRL_MMR_PMCTRL_IO_0_IO_ISO_CTRL_0;
+	writel(reg, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_PMCTRL_IO_0);
+
+	/* Release all IOs from deepsleep mode and clear IO daisy chain control */
+	writel(0, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_DEEPSLEEP_CTRL);
+	writel(0, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_PMCTRL_IO_GLB);
+
+	return 0;
+}
+
 static bool wkup_ctrl_canuart_wakeup_active(void)
 {
 	return !!(readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_STAT1) &
@@ -36,3 +114,10 @@ bool wkup_ctrl_is_lpm_exit(void)
 		wkup_ctrl_canuart_wakeup_active() &&
 		wkup_ctrl_canuart_magic_word_set();
 }
+
+int __maybe_unused wkup_ctrl_remove_can_io_isolation_if_set(void)
+{
+	if (wkup_ctrl_canuart_wakeup_active() && !wkup_ctrl_canuart_magic_word_set())
+		return wkup_ctrl_remove_can_io_isolation();
+	return 0;
+}
diff --git a/arch/arm/mach-k3/am62xx-lpm-common.h b/arch/arm/mach-k3/am62xx-lpm-common.h
index 36dcd20a9b80..2d110bcca0fc 100644
--- a/arch/arm/mach-k3/am62xx-lpm-common.h
+++ b/arch/arm/mach-k3/am62xx-lpm-common.h
@@ -12,5 +12,6 @@
 #include <asm/io.h>
 
 bool wkup_ctrl_is_lpm_exit(void);
+int wkup_ctrl_remove_can_io_isolation_if_set(void);
 
 #endif  /* _AM62XX_LPM_COMMON_H_ */

-- 
2.55.0

