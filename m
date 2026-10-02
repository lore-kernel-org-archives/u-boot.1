Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AA7CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 12:26:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D28CD40E2E;
	Fri,  2 Oct 2026 12:26:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y9fhF4Ys_4VR; Fri,  2 Oct 2026 12:26:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1B4C940DB8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790944012;
	b=nn0EVNs0ICu3W+G6mEdxNUIilCQH+ax2x/yXB/HkQVURreMpX/fA2EAag1husCG5XlHh
	 Pn8XKM0Pm+I8ikCgW40yhjbr+dMIAq8oMbxFehwK4wSPiHyAIB3QEXqFUdQroqOd/LeNe
	 J2wQxDE9c/qVIDDnPcsN9PF01bLPQ5U8LrD2KTqWZEsGRyfblU2MsJMOZozf+XKQCamiY
	 ucwq+Hi1RBhYNnBBAORnu/9q7LUl5tmh4QSEXlABvP1wCKxIvgTkjEsM/qagwfkTHtUQn
	 lIOcEIFsSKBTO8RkgxIl69P6PLt1uCeZ7qnVqKXCZvVxxv9MgvqebBspwGhHLtm5lVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790944012;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CFrDzJgIodQ2or8UJGSL0JnyKDZtrJ+wJiBaBtctzwE=;
	b=X2iHLK4l4e1OacdtLS/zBbxC2opn/Qvk2wwM+hVsBGG4/cAIGb90PXrdfwaEAWBgyuNZ
	 y34aPArSqFGhgeq8nM4al6CGhs5+Y0xDX+5QNOLgzN0K0ExNJA376nSLnHzofK42yLlC+
	 KF7x8Pf+wlzyFOV+xGWqGCXxbpxX43SetrKBcjl56H0QTup2BbiwPv4+q543xhyG2YHWC
	 UbV5lu7tlqLqOGQDSZikxxFWnsak7hl0AMbeVpJe2rP3LIwF/QcRexV8kwI7UWQqAJ07i
	 +wMfkD+YjsxsEH77evHMCXcR1og211fwOpSiPQqb11lp0Pis9rxCYz50Q8zGwYh43Mg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790944012;
	bh=CFrDzJgIodQ2or8UJGSL0JnyKDZtrJ+wJiBaBtctzwE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AwWLSoqQ7ktGbPueQRZX312KXsR+tpd5lL7g4bKaLuBdGMMhjojmrpKgSJgMu/54S
	 nNjAgVSomUuzhsajuoaJgovuaCitoEcnckizEGPHWofsP9oC8JO9POxnXS8oGc6Cft
	 KBMgjDouJu9TMN0UF43524SkwdRM6JxDlKB7ysc/3b1SWDXpsu2x6aEs3k7nu4K28U
	 2uybCOQT2AHXBEnT4MRgzlTVEkcgkrikypee2eLZpH+M+oR1qFO1Mi+5pluufzIGVa
	 fQ70p9xvWyON9z5y37oC7pPcG+F1pZtjSKGSyZJWF0JZVeWBbkq67yK1iId/fpBS1M
	 SrtgYPszzXvcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B4C940DB8;
	Fri,  2 Oct 2026 12:26:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 989B932A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:43:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89DAB400B3
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:43:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oISI1msazU0Y for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 07:43:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 793FA40057
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::4"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790927024;
 b=fDUoQgi4+5TP3Wg51f6jJvYnGe7yjYloT1J0mqp2rpHDLjRPG+5eBSCimFcGjdNANb95
 zNRAZQr3rX8lZoZBlS016aLIkbLsqNAeIN15Az26JnDWq+t+LE5VTjg5ywpx7g6T2pb7g
 FkaiBKdCAhixS+F2gW9M09p1jnT+CiVWdyN5qm/tbt0pLNRmkj/x90AYMJtJXAwHxR1q/
 f6yJCscZdIJZ/OGbIJlqUh30FNa4mjaCLhdEfHFr3jefAWNleSpS+9jhTXXGR8Kawy517
 EtTHbYHPiMgKXx/2OCmBRIc7GOxVedsrk3vZKq02TOK3S8hOnlMGLxzg58+8pW8HeXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790927024;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:X-Amp-Result:Received:Received:Received:
 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
 References:In-Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=CFrDzJgIodQ2or8UJGSL0JnyKDZtrJ+wJiBaBtctzwE=;
 b=nE/Mof2bAfv4py3JQ9xxQ/0ahdeRPAzTUK+x0IKLcM8qA160C1l67PX0N7E/ZgkcS0ly
 QoJA6jI5qkcAKkoFtzRDLsc6+d2+H18LQsCSaWU3OPIpLuynau/NYVVTwogDszdk165e0
 zwz4MoOtaFy5+BPaYP66tk30cANxIDkNLGzO6ZQXSTn72F9Q/jVP1shhFuhPWJ2l8aCXH
 LHAaVYKLPVwwo9r0Jx95jSAMI90lWoIFxQeodpbhY1nj4GQu5TBDK6nEvz4FY3X0NYfvP
 P+GG8a+d/dDMmdLiO0M4pqJXiDes9X2oT3XhcWr/Ojd8zPUFsWmaMx3F/bO7l2HSnyA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=infineon.com; 
 dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b="RDoeg+B/"; 
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:18f0:1e00:4::4;
 helo=smtp2.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=RDoeg+B/
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 793FA40057
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1790927024; x=1822463024;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CFrDzJgIodQ2or8UJGSL0JnyKDZtrJ+wJiBaBtctzwE=;
 b=RDoeg+B/aPR3XLO5ILwx6fPTZDOjU8lxYYeVwqBRA3Dvz1uIqmOdF0sL
 qg6LJqNepGh5L/FXyC3+8kaKjLwisq1+j3HkZlYmqrfzY6T9r2poOEmTn
 +d7zXaOtXxKFghJkthrMdcr5hEm8je4yhdZx8/ytX0TDc/G9s0/luNb34 c=;
X-CSE-ConnectionGUID: oATCICUGQtanOv7LX8T7ZQ==
X-CSE-MsgGUID: buIbv0fbQF6xDpAE8pbo3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="181907784"
X-IronPort-AV: E=Sophos;i="6.27,136,1787004000"; d="scan'208";a="181907784"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
 by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 09:43:41 +0200
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 09:43:40 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE817.infineon.com
 (172.23.29.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 09:43:40 +0200
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.049; Fri, 2 Oct 2026 09:43:40 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <aristo.chen@canonical.com>, <u-boot@lists.u-boot-project.org>
CC: <trini@konsulko.com>, <vigneshr@ti.com>
Subject: RE: [PATCH v1 1/6] mtd: spi-nor: drop the duplicate EN4B/EX4B opcode
 definitions
Thread-Topic: [PATCH v1 1/6] mtd: spi-nor: drop the duplicate EN4B/EX4B opcode
 definitions
Thread-Index: AQHdUkB44a8PAE9NpkuxALdcozOQ9rbp3sEg
Date: Fri, 2 Oct 2026 07:43:40 +0000
Message-ID: <2d36f1c8b5a84d83ac27b0b0d08a82a9@infineon.com>
References: <20261002073357.382228-1-aristo.chen@canonical.com>
 <20261002073357.382228-2-aristo.chen@canonical.com>
In-Reply-To: <20261002073357.382228-2-aristo.chen@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 02 Oct 2026 12:26:15 +0000
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

> SPINOR_OP_EN4B and SPINOR_OP_EX4B are defined twice in a row with the
> same values. The second pair came in with the Macronix Octal DTR
> opcodes in commit df3d5f9e410c ("mtd: spi-nor: add support for
> Macronix Octal flash").
>=20
> Drop the second pair. No functional change.
>=20
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>

Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>

