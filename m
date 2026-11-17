Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C11C606A331
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IRIksBxA;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=accvJjtR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 440F240557;
	Tue, 17 Nov 2026 15:54:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id udcvBYDnKTua; Tue, 17 Nov 2026 15:54:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8924B40564
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794930874;
	b=JkAVa+EK4KZQn8yqTd2kt+givxRzTJ42NzO3/iOYi643Gj5meoO4mgb+YmMzxKDSQ16W
	 PIBtzX9o8FPntXaBrtewV5pD3Kqe2h02WYgJ8NQ/bSp9ZIQk5nQuJxaE7n4EcCg8Kx0Ks
	 i71wuZ78eShs1a8+qv6t8iN9BPX4vQkiKtUfYAY1DsJzy2gGo++VdlbdJg1xr//eJo2fs
	 huJzlxHHQg8SgEUXl8kB+H8eN6F2ubqtWxBA1WWdIDI7/L7I1lNYp8IrfjjRcFC2K41+z
	 oCEbdJI9HtfXGLrW4vApfajbomIcuknt0UBD/2nXc0zLSyLptdO/8XrNmv37CQw6L/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794930874;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XiF7kpcZ1po+1rQjWrr0TkPCOWScPurUcT16meiM2xQ=;
	b=cH7lfFaY7l71NaL2R7u/egIHrJ2momTCWYarbMDCxZj33T6EFkkkOOOUwDK1AmpPuCPB
	 KsYcS+sqSJC97+e1eNX0J0oglO41VtAy2RqxBQer8rZtf/jWop6AduKe/l5sP2E/plM0N
	 2WFpplM864r60K/vUrNbXl/VvoRbWN8atG1i84Mr5NsWyEzt2jiakViVQKU1CbwA3QSYs
	 Q4JoDjYcZoGC9Xo6aDrCJU5haQsj0mvRXn/5GXdRU2O7/NlifNY0nVYO8oFROJdc9hLOY
	 BipR4eHHKD6mGX+RNNs0Dr2U5g1l6J50xA/c+iRfC8gLZ9MFfgrgyj/6jhyBZjvMjsg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794930874;
	bh=XiF7kpcZ1po+1rQjWrr0TkPCOWScPurUcT16meiM2xQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IRIksBxA5ExIifIohmSCBXVl67qWF6bOhikoSXnII4EllqMXXoXP2Uum2u+2DSO3F
	 8KebTHm0qIyk2dRpsS55WerXv6+xtz9eQuMmGVu0N7B+JjyQlBG2G5j1s9zueNx6xo
	 SR6oVQd45MShwOWxs7bWLSUH34GAet7+CFFTe8ICvIdpgU/BKFdc6g/AgeDY+2npsX
	 KQON8119rms1bKWZ68/7LBafTyJ9625DBe25ywZRQLnzr57F/juay8RvQNbWWy6sBi
	 CxJDX+asU/6WtZ93xnivRNYPakGckxvJZBvQ0M5WaydkCgPv31fjtS2u9JZ1ISg73o
	 CqnkEKjX2NO6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8924B40564;
	Tue, 17 Nov 2026 15:54:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A7AE70B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:54:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 80F70811F8
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:54:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e8Ng0zrNEv8l for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 15:54:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 820BE80CCE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=accvJjtR
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 820BE80CCE
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:54:31 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so330835e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 07:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794930870; x=1795535670;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XiF7kpcZ1po+1rQjWrr0TkPCOWScPurUcT16meiM2xQ=;
 b=accvJjtRrSP3uBvw1QYgD16grMdv8FucW6GEj1VLEdVmbE5xEDE09FxQbSgDK5eI5L
 T1vFuJwKSGCn3oZ0LUhkPDZoW6YTPwNK2pz+GvyyUcu6nrGBt0Ck2BTIq5CB9wvvLyZ9
 oMN8jR7Coviye82B7mhfWvunNc79ZLdGFLVUFi+D+h9qFET3D2ftMPaLgdlNRWJXmYWO
 4o/c1LomMeMZ1UrMfkb2FN6xSYftK1GhfgEEvHVx9pujcTBiTn1lJ7ucKxfDYzVCGeKi
 uYuUZUyKxX2vNR7UhF1wVRJBaF9GoDrBZMQIEnjDawwzWN7mcO8Iw/G3lIslOgJ5kPoI
 hJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794930870; x=1795535670;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XiF7kpcZ1po+1rQjWrr0TkPCOWScPurUcT16meiM2xQ=;
 b=TJY99lMfun+Ij7wp73J36ZvqXn9zKnMlK1ntIiE9LGChJFbtOG12XRduBpCiNCd3Lb
 NXQ2gcULkrQlKj+IM/VeFcakIlab7Lq8NGdcWOKnToK/+IiWNdn3VOv5MbPgcTt7FfzY
 gDPiSI8tAEg6F8KMByZIHhlTyUBaGuyUiuaduTGVIsStaDAM6m6cIn8jLtl8CHrOZmfi
 CkD01lcz0oGGtHVFovaRIfLFYt8rM16xg8ePkpDKNJn8PMg3r5Klr7cjn6ZyfGmba3W2
 uNSYkcN8O2EG6YxMbZBtlNFyT+sba2UClEsNj67gbVcxUH9nEBXdLWI4/p6bSnKD929c
 Cglg==
X-Forwarded-Encrypted: i=1;
 AL+hErF5P7FMpC0ArOjHfkGHZOyGcK5A2BZzfG2I5LTVCI8nom+/T1U3fvMxphga0xyZj8AKgc0BGH8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/5/wQeBcge7y2PJlwpS5mabpSlvZYOQeaT38CrKLkL0B+GJo5b
 Shw+speSOrg/tC4yMDJGuH5zWo0uc4EkT0PpdxffZzkfKcDaHZDCBFlP2ynEgw==
X-Gm-Gg: AYBFou2WA/EHlZtQeoAdyAq9vcJVTl0bdbHgsG93xQVRBd8ALyPtLdimz8BDqPXjY1e
 XMP/hbfEd3HhFhOdkAm2IB/iClX/dKsbGdHvvQpS6RiVQ0x+UkJ6C8zXB5RrZX/OUOzDiJTghm4
 I/Rs6mTTUM+rsuTdN36KYPUrRzj3y7LdvZVsdDq+Tx7Ca+gM0JnaejXJ+VUy8/QQtu3CZGBZE2V
 wZVBbyK/SBcejGUk4vBrTC0M6rdIsroq05zre3ljmCo3ZUXDRxPgaEcXO5nYmTJEWHJa63/w+CO
 Lx2cRbii3U3NIeX9mXlvRAgf3INWsifHJkKzUpS/PMK8oi4P/c4/aVxpnDZOjdYPYhUjawZyo1a
 iG0vjSx5Q8MYgqgiXPHxztcGJFx3L2eul2vhX1vvnGhqan4+ANZAZP5y6aF93cYLcMPuIrCvEmU
 s+ZetVbNC1J8lYdF1ezLqGeQvckEwzb6o2+tpJIozCtebZrfRjJn8yv8Ew6SEeAJu/VBI1siE2q
 /MlP2AB1OWc5acpXSnlNR+khngKnf0aEmjxY4gd+AZw4z/HpnJkU+ouRU51dJQG9bn+I9Lp/03G
 x77b8eKo8wv1OThjYjxGBB2FY42g6iYQS9+tHNyuqNzFyGLp+NlAGBfoTJIjKoLKVIXNy+H/ngo
 81egA5pfeFbuSxctwwlRH9JXII9aZAFe+nmG0FVMbi8SANhnleUgxB0wUXTAH2CyMh4pchFR85L
 NbO2ZzxeOt92HT
X-Received: by 2002:a05:600d:2:b0:4b0:a307:46f8 with SMTP id
 5b1f17b1804b1-4bb55a57c2cmr229206725e9.10.1794930869809; 
 Tue, 17 Nov 2026 07:54:29 -0800 (PST)
Received: from cypher.home.roving-it.com
 ([2001:8b0:fb11:0:3889:86e0:d449:e2e1])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4bb732a2a9csm131403045e9.3.2026.11.17.07.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 07:54:28 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 0/1] MAINTAINERS updates
Date: Tue, 17 Nov 2026 15:54:18 +0000
Message-ID: <20261117155426.2069931-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With the departure of Simon there's opportunities for new
people to step up as maintainers if they so desire. If you
are interested in helping out in this regard feel reach out
to the PLC (Tom Rini, Neil Armstrong or myself) or other
exisiting maintainers in the community if you want more
information about what the role involves.

Peter Robinson (1):
  Update maintainers and get_maintainer.ignore

 .get_maintainer.ignore |  4 +++-
 .mailmap               |  1 -
 MAINTAINERS            | 46 +++++++++++++-----------------------------
 3 files changed, 17 insertions(+), 34 deletions(-)

-- 
2.56.1

