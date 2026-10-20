Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C48606A323
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KUSJDDLG;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=XFx1tcAl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8629B6085D;
	Tue, 20 Oct 2026 17:26:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BncqtHT1Gzr6; Tue, 20 Oct 2026 17:26:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8E140607B8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792517177;
	b=NMweF9fq4exFB1yzM7j1FSJu7mG9XsGnzIsqqSkcS8jU8zhEUKMceu9l41jlIdYQX9PE
	 K3rUmqIOUBbUaSLp0CIrXckWmOFoWYRqmXcubKuYPPmpopfnJMoepjZh+2ZMQVFVIX78J
	 MH11eMPQ2kwbpI7p4gJpBtQnHg9q4WrahVHrUzHem3Pxz0MWtnyqyxhU9D8aCi8G4uUBk
	 OW4rAfRM5MEyOlF9h+3nFMLziNMjxcISsY3OFl+qr9JCkDuqBV5sarJUN31abUCnK32iK
	 6SrpNebDV1xMcjpQmsJ+sDkRJ1wtfBDVg37Yc0u5hTHtGDLLu1LdmVv2ZC7SeuRze5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517177;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2OKZEtI69dx9dUmXGCRjix0LwcCT7XCUoRifCOnxGks=;
	b=ssaa8lPF9i2wQS4DepBjEIoGzP5NsPEPpdpdhh/f17/jfJgKys5rxUHmXKxUNNFXC1lK
	 KziF3FCy4bTX090z9/wOmSTIU43HT8ApvGqPSPOI5mvssH7kLhkl8PQWxKhCGNjuhSHP7
	 I4PC4enhEAaOnjE62BaqAVVaydxJnBCeHW7uKmKzDxT78KYN7ostAixS2Z3X0y3C8DThm
	 JKJ4QoE0MFS9NMJbF2spMZDaAIqus4oc7d5mSH3Wimcpx7lttaTE7yZJr5oZO1/h8pBwV
	 7SXMTDph6zDF0Ta1G9yj8sGFv6zr7cM6X3iQsy7Tf1aFjiHp171QoQLpOuAUDUw/Png==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=XFx1tcAl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792517177;
	bh=2OKZEtI69dx9dUmXGCRjix0LwcCT7XCUoRifCOnxGks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KUSJDDLGYbnv9GbhkDIiwMCbM1fLzY8NNAD2cJYd8INGCCV0oCV2J9i3498odqRBR
	 IU2aiz7nNAR6JG6P6/s6SXrU/PggHmRHOY6TvasK0lgSfH87sRmG5oql7TEHyITVp1
	 GW/t4nJhYMexEDxS7GVnuPzWsffetYYN6PNVQEFRODubpbcv/a3qvv8pSerD3JyLXU
	 fMwaB7NOZOtz+TDM/JD7IWLEftKGm4lTtJaLtojXJQSxCD94Laz+Dh+rfAyo631yo7
	 +5g6ZTwH4rrOlHUGhUwk7JhLv/zRXz3w9/vF9V6eHhlUjf6Cx+ZdNEkRbuh8aHD2Po
	 2UOqrDrgCxYuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E140607B8;
	Tue, 20 Oct 2026 17:26:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 98AAB1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7F15D6078A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:42:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X3JQM8hs1_bC for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:42:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7EA736071D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514536;
 b=nngJPbsjBOH6UG+oqa0oc282I0vsb2XHKB2Q8A0aWVJUrDXWaeYyusSEwBPPqjdHZQeP
 t4hPzsf0phOa4aLATZ0VL4V4lQLjJ+dceI1tzErZorVBWinTWwsV9sRhu45hpi6bon9m4
 iXTEcGyzdigqZWc5Iqc/X0zEui+PhEJAhWUeGwoFUhOcB1u4hlKjxNOFwuP7FEWOll8XE
 d4hh2AZXGX3aW2tirMHtxive7THeG9FOIbUd2GOUgxMKaLizLrjkofmdXR0IA/6v/O/hl
 cNYYUaJUtPIzDRnngpmW7WCLf/IE3Nyr9k47ErV1rwKm/tJ9ltigpugEvs0fkEabVJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514536;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=2OKZEtI69dx9dUmXGCRjix0LwcCT7XCUoRifCOnxGks=;
 b=hcgE2Gd0blL9eV9xFwKziWWehFliUO/mG/8ffWO/arqEjTFVtYNTiGXcFRAvkrCXq9Si
 kZFMBOUyfbiMQDGvh74+g0u+jxRiUxdYDbeW82z9jo0DRaxdbtQWHaSypl+YUnLXAljWg
 udzxFbcQr47BlYDPPIwfUE0xWPwxStKqdQgmrMKIQTP/CIe0PfEnhJ4201HSymU7JRR7S
 XlNXkQIV90mafJNEi5Cl7dPt2JBlgQCt6TAL9KSo9dNtvp2hpesEkklGV5zrDbuWC6txw
 zy9UJIIZ7ulrrpfsgi9gueP9vAqY6ElU0R0M/1YzpfkkKrfcRacbnQxZ2g1N3eDEJwg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=XFx1tcAl; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=XFx1tcAl
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7EA736071D
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:42:15 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so29040385e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792514534; x=1793119334;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2OKZEtI69dx9dUmXGCRjix0LwcCT7XCUoRifCOnxGks=;
 b=XFx1tcAlTIlzPYI02tcLCnN+R40reo7d0g+/In3TObgmhV5gxTEj/zyR/903gjYAZv
 MtyK+VAy12bEuQkgj+Zpf8NOH5n5ij05FdjJEsGApQo6RJcuxi0eBr1vHZWKrsf6eTVM
 PVkGdE4T+vv2rMwQuNiaye2b1TE9JmVhbLtb+D9pvxT0TeqgC3G/QDZSfkFBOkRoXB/w
 2YAFW7n3Qrvr0gHkzyGRkrbNh+hfd0O5wWpMyag6o144h/Q/0OBXdSoquVLDiG0OH13g
 v28e2F34RCsEWNGyBU8ZWcWRvEvDP1sNAxFUnG4SQ+GRa8FfI3nr3XQt7kl472PNT+Al
 hO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514534; x=1793119334;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2OKZEtI69dx9dUmXGCRjix0LwcCT7XCUoRifCOnxGks=;
 b=cIWpjVTTGrYd7ryCCGvgp2Feak60xAznZP/0fOqiM1w5fbDQOwg27ujbN0C2cRNzNe
 xgPjtX1gidLvCkPrp6ktAM+3FmdJ5hxaHhiLycw7n8e1We6aqhIOU3h4hqk2cyBL8ZJr
 mdhMSIx+ImxGj8fRzY2H5LyV6jQ9UAOMzEx3F4/Ey50A0GoyCHP50P+KHSuybycy+6Es
 mDEcLCyxWIr0fCKvSP16zPCBytTydJmd61beJnOyzAD7wwnZxgTlmqHMHvaQmOpvpvU1
 1ECZm69Rtv95UeoYWh1PYdv778/g3uE7GXe+5a0zOZvsfFu+N4e8MNNbhsGsliMCiN2h
 F7Ig==
X-Gm-Message-State: AFq9FYJwx8sKDSWOCwkhaniwhynhfYREL6XaaZb7+whvSPQIapGsCyXE
 QJRvt9X94UHvZqf139iL3F3+JfPt+6iHhl/FFX6A8gPdkd9nQednse8og0WWdEaa62A=
X-Gm-Gg: AYBFou0DM8g/DAoAJoeTu+aYSVl1kylygZUBjbb8hq6RplKnPyNONtDc0ZT9cPUSDdQ
 f5QXPB2/5XTtLrS1S2yb0d05qj3hDyK/tSewQfFWvz4FvvlwIIZH3BmEIEP8wDLyIdIXFmYT6/j
 1ryOqZgHUzKGiBn8kPtECT0Dqizs3UldIuCv3dyCG+1L3id1cW2HXKz+eCKP17oPu44vqWz4UU3
 Il61oceHs4mI8dXrTWsIw7kemb+3cJ5sMLyPKiqaBKDBmU44A0QAhc3X0ksFg++bI4+BY8/ah6a
 RdwLqzR0kbmKYwaKmtEzV3UYyjmlSOTtKWCVD/hJcq0laje74UVDPhA4bVdhk6VzQiHnUAPJgXL
 AddtY1IUBpfONyP9elEMBnXgSIlmpiFR2hyqRlQ8DIEWt3jSpIQMweISlVzAlREs0vKOEMO3ddt
 3LoEySG27aCHLKQlcn+pN2ywBDP/VZ6z+J5baQwzmxdAaWDssQBilrRd5y/4KzVBYCkZ08ZRySY
 3EjiRH87JbYcQJkcUxz5z8yz/AQT3k5n8733io5J6MlujwtIfYy/w==
X-Received: by 2002:a05:600c:3b09:b0:4a1:f7f4:7ced with SMTP id
 5b1f17b1804b1-4a1f7f47d43mr49316115e9.17.1792514533890; 
 Tue, 20 Oct 2026 09:42:13 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc10de99sm643315e9.1.2026.10.20.09.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:42:13 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 20 Oct 2026 20:40:56 +0400
Subject: [PATCH v3 09/23] test: spl: Keep the payload create_fit() is
 handed
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-spl-fit-compression-v3-9-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
In-Reply-To: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
To: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Max Merchel <max.merchel@ew.tq-group.com>, 
 u-boot@ew.tq-group.com, Petr Hodina <petr.hodina@protonmail.com>, 
 Bruno Banelli <bbanelli@gmail.com>, Carlo Caione <ccaione@baylibre.com>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4736; i=alchark@flipper.net;
 h=from:subject:message-id; bh=e6f8QyHrEIK11RwDFcUAnOD66hI2YyNpKqfy2Sww2H4=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRdn7lK9H7Wj+8iB458lT/oU/RoydpHDiqipbwZZaFqJ
 3bP8P7D1jGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBU3+VnZJjItIu16cKNkOlp/+dOFHq5sfzyodKlTBukpQwDVX6/mvGR4b/7/SI
 WxkvmEXfKL77s2WZX51r5ccnunz8jwld+kDaq8+cHAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Tue, 20 Oct 2026 17:26:00 +0000
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

fdt_create() clears the whole buffer it is given, and for a FIT with
internal data that buffer covers the payload the caller has already
written at the offset create_image() told it to use. So every
FIT_INTERNAL test has been loading zeros and comparing them against the
same zeroed memory, and would pass whatever the loader did with them.

Keep a copy of the payload across the call. Have the callers compare
against their own copy of the data too, rather than against the image
create_image() may have clobbered, so that this cannot come back unseen.

Fixes: b93cc1e73e11 ("test: spl: Add functions to create images")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 test/image/spl_load.c | 46 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 334ec77b18ec..212fe0f08428 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -164,6 +164,7 @@ static size_t create_fit(void *dst, struct spl_image_info *spl_image,
 			 size_t *data_offset, bool external)
 {
 	size_t prop_size = 596, total_size = prop_size + spl_image->size;
+	void *payload = NULL;
 	size_t off, size;
 
 	if (external) {
@@ -184,8 +185,28 @@ static size_t create_fit(void *dst, struct spl_image_info *spl_image,
 	if (!dst)
 		goto out;
 
-	if (start_fit(dst, size, spl_image->size, external) != off)
+	/*
+	 * fdt_create() clears every byte of the buffer it is given. For
+	 * internal data that buffer covers the payload our caller was asked to
+	 * write beforehand, so keep a copy across the call. Nothing written
+	 * after it reaches back that far.
+	 */
+	if (!external && spl_image->size) {
+		payload = malloc(spl_image->size);
+		if (!payload)
+			return 0;
+		memcpy(payload, dst + off, spl_image->size);
+	}
+
+	if (start_fit(dst, size, spl_image->size, external) != off) {
+		free(payload);
 		return 0;
+	}
+
+	if (payload) {
+		memcpy(dst + off, payload, spl_image->size);
+		free(payload);
+	}
 
 	if (fdt_property_string(dst, FIT_DESC_PROP, spl_image->name))
 		return 0;
@@ -324,6 +345,7 @@ static int spl_test_image(struct unit_test_state *uts, const char *test_name,
 		.name = test_name,
 		.size = data_size,
 	}, info_read = { };
+	char plain[SPL_TEST_DATA_SIZE];
 	char *data;
 	void *img;
 
@@ -333,8 +355,11 @@ static int spl_test_image(struct unit_test_state *uts, const char *test_name,
 	ut_assertnonnull(img);
 
 	data = img + img_data;
-	generate_data(data, data_size, test_name);
+	generate_data(plain, data_size, test_name);
+	memcpy(data, plain, data_size);
 	ut_asserteq(img_size, create_image(img, type, &info_write, NULL));
+	/* Compare against a copy, so that losing the payload can't go unseen */
+	ut_asserteq_mem(plain, data, data_size);
 
 	if (type == LEGACY) {
 		ut_assertok(spl_parse_image_header(&info_read, NULL, img));
@@ -355,7 +380,7 @@ static int spl_test_image(struct unit_test_state *uts, const char *test_name,
 							img));
 		if (check_image_info(uts, &info_write, &info_read))
 			return CMD_RET_FAILURE;
-		ut_asserteq_mem(data, phys_to_virt(info_write.load_addr),
+		ut_asserteq_mem(plain, phys_to_virt(info_write.load_addr),
 				data_size);
 	}
 
@@ -761,7 +786,9 @@ int do_spl_test_load(struct unit_test_state *uts, const char *test_name,
 	struct spl_boot_device bootdev = {
 		.boot_device = loader->boot_device,
 	};
-	char *data, *plain;
+	char plain[SPL_TEST_DATA_SIZE];
+	const char *payload;
+	char *data;
 	void *img;
 
 	img_size = create_image(NULL, type, &info_write, &img_data);
@@ -771,15 +798,16 @@ int do_spl_test_load(struct unit_test_state *uts, const char *test_name,
 
 	data = img + img_data;
 	if (type == LEGACY_LZMA) {
-		plain = malloc(plain_size);
-		ut_assertnonnull(plain);
 		generate_data(plain, plain_size, "lzma");
-		memcpy(data, lzma_compressed, sizeof(lzma_compressed));
+		payload = lzma_compressed;
 	} else {
-		plain = data;
 		generate_data(plain, plain_size, test_name);
+		payload = plain;
 	}
+	memcpy(data, payload, info_write.size);
 	ut_asserteq(img_size, create_image(img, type, &info_write, NULL));
+	/* Compare against a copy, so that losing the payload can't go unseen */
+	ut_asserteq_mem(payload, data, info_write.size);
 
 	if (write_image(uts, img, img_size))
 		return CMD_RET_FAILURE;
@@ -791,8 +819,6 @@ int do_spl_test_load(struct unit_test_state *uts, const char *test_name,
 		ut_asserteq(plain_size, info_read.size);
 	ut_asserteq_mem(plain, phys_to_virt(info_write.load_addr), plain_size);
 
-	if (type == LEGACY_LZMA)
-		free(plain);
 	free(img);
 	return 0;
 }

-- 
2.55.0

