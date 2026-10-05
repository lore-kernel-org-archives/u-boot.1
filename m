Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9757CA5FFC
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 14:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7261880CC2;
	Mon,  5 Oct 2026 14:01:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p1Hz3mkFtMg8; Mon,  5 Oct 2026 14:01:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8876080CB6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791208877;
	b=oaibPq/zpPHpulBpfNHR64NTfMpxJQHtD1LnyQ8vmnDdwhvd2qjEeukee5sxjsCDBmnJ
	 s8zWVzu847S4XKmYEudvtosUh9MqeIQSbz7q7J5A2GtMmol5e9yzjP3qKTfYIOTSXxZqq
	 gv2LFR41xIe4x4a/4p89TU0pEsW8UizBRhYnDl9dvClJmdxIvKrn4oaP2a/7ynmGqg9wc
	 in9DTaohOE1ZqgrZ2ibpGTK9Z0rDNKYfVsuO3sH/sIXSp82YkOyF81C5JZzPsuSunH0Bj
	 6oDGRfVBnMOkcEIegV3QWm884gIgTcAWA+K/1n7NS77Ep4uLqGLLzwb6B8wqP0sjOFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791208877;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uSg8Cv0LxvCiEci6cQXQvNgT0AMd9GjHGQf1liPZdaQ=;
	b=m1BsgGZXNVYnexvcOxsWkF27cmK2M0hS/8yC3sBZJP2R0onx760rSRBCCAfslOeFeUEj
	 SyzshU51pNjKilOKLiKh1624heKsHMP+6m8MwldWaKHZlR+hF3Sgzw/lPNdQ23PlBQEy7
	 zWdIFAvpmQ6jHoCW8/fi2AjghAxFoLGT1I4rpkKEhN2vV1xKXRw0WYmCTRrcrEQU5iOn/
	 L0aPFzswoxero4jm7bzxoQIhfowXeBhV0USG2qZb4d3nR1mIgPvmMAoLIVgrB8/Q7BA7P
	 xoLiBwMTYdES4/vm30Dy3PEsKgQb82i6+2c4eLSzGnNsQDu8WjyrOX8OxVvTTUJinWA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=brivo.com;
	dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256 header.s=google header.b="kRUG/NZb";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791208877;
	bh=uSg8Cv0LxvCiEci6cQXQvNgT0AMd9GjHGQf1liPZdaQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sspv1PEWVv4AEVyliox+rN1gGW5aT7IiHlDtJyfXtz8WZDBBosAX9okmJKoXhm4kS
	 OcKIsQrjc73Qe0CZ5omC1OrTAB/KP/YNNlfIeqwrO35HSK6QMGbCwhqf705bGt/Y2+
	 c1NAMDqMko3IHE91SYZbN5cJuY2+5Nu2bAzSZ7fZImSEuTeOEHH05v36vOctgtdoJv
	 aDsgdF19XTrI0/HVS86+9v5TEKFWC3gZh9Gngr5pqP4215QIcl5AzVAJU5zMjoE5NK
	 ap1ZqfJVKGij7HNazq3PtU37JeomUBS4czflEKW6t3dXg6Bdd8aKm/aziZVsZk12F2
	 seE1Oxy41LjyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8876080CB6;
	Mon,  5 Oct 2026 14:01:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D628F338
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BBDFD80BE0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:55:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KOvcgz73yhOD for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 13:55:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2302780BCF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1130"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791208555;
 b=WbIcpmgLV+waHSdtfEIjjwwtWV2dhN6Xt65EgpcCcfYQbIj8BQJQaELH7G4Qk8t8bdyt
 KsX0XS/X7aM3rg6WxxgDRiaUucAmiZ33gl6zHn9caFsmwBYpUuvdI0aj/gnTD+z4B2JXK
 S/hoLvuzGEIA/OERntCvEYyDgD1aaPubItMRnAir6NutvG1DGic56pF9NL/4mwu2bmiqu
 F6etoenhN/Z//uDuM0Rrq1/j8gX6xatOjiGirznsZcUsi2P2MEecBQZYmZPM6xV/UpJfv
 559393sReNtuywViLwoWlGXgBNJ0ykZbiDeE/HvIY1vAi6nKDIMwibLSBzgT9c+VZiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791208555;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=uSg8Cv0LxvCiEci6cQXQvNgT0AMd9GjHGQf1liPZdaQ=;
 b=i4cok+4cqOpChS0sxbgtOu0/OpbEhH7A5FKMMRBnojpRM6aUdr+wkStfmE5Cpc0D612o
 0ENQgH63IhX2kjNDTspmo6Mgn8UAKBEeVivSZ3pBhYfG3DDWGzoODJKdpg8y8D2wTTa+/
 G6ce2F3cP3JfOMsvlUOzbi/nI8Ip7yG9c8Vf5EMShtQ7yuxPqySpKnLO/O08B0Q8MgWH0
 i4lFo01EBdtAzFqbWmjQmWSvicukc5CULr+a4DjJGLLQSV2CwM1kVU+tuVqtd5xmiviMp
 DqM3g1OWjAO+fSR2EJbRsvUGftr3gI4IUQ+Xx5JVexBpNFGoKo4yptlU7STm6PHIJMg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b="kRUG/NZb"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1130"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1130; helo=mail-yw1-x1130.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com
 header.a=rsa-sha256 header.s=google header.b=kRUG/NZb
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2302780BCF
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:55:54 +0000 (UTC)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8a08bb1eda2so15302597b3.2
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 06:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1791208553; x=1791813353;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uSg8Cv0LxvCiEci6cQXQvNgT0AMd9GjHGQf1liPZdaQ=;
 b=kRUG/NZbIm6vnsJRmkSuzBevcrKcQ7ER5J+5HuU7v4phxQ0Nwv3PnVwPSNSMR2hRY6
 bkQyPKXZU6l+boDtkyOnGdRQ0PY+1eAcXBhpply6b6IU8pvxpvyXCtcj404Va0SZE3HH
 AJzQlOxSCTZKI/B3XjGJAqDyy6Xxa9WIE2MaxqUouY61T7Tw5z1BPGFc/MwrrPbTvtIC
 GUUgBwrGecyvLUACdAs7HP+1RapkLT4LV1DrEFr5+JGhgA47XXkwbbtpEEmXTTfr/pcx
 1WBjI8zehf3NuhuQ+exgEt0QY1DALcU9zrdymqMO8gpDUmeFjhPRtKbLTDtx3RE/inUL
 VhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791208553; x=1791813353;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uSg8Cv0LxvCiEci6cQXQvNgT0AMd9GjHGQf1liPZdaQ=;
 b=JLOte5DYtP2lm2UuKAZVDeE+ESPp5skvWBslpm1fi9CQygNZMISFVKmICVrXo1Xd23
 os3phRciaH3VGPDgSS3+osljbSt4BHc4Flaszbb3Cm6to3NFamoNPrI6vMqye71AFO1w
 U9Ibtn3Uce8efpUCUuH4Y45LY+5wjNdkpWI50EHEIHw9VeYLiZEfHYl46HCAgT1Ms2eB
 CXTXBbtqXTF6JqVKybG4MHaZlDxGGE3B7RGn+pMRZAagXtlr2nHPm7v3pjYz0WIZrCr7
 KglCYnrsafx9kIy8GgSJRqBUpXa8Ya7I4KdfBjglGUX4+5p0Py8HFQ+3LpIDgtFO6h3h
 Grmg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyww563VPJ5V8LGIe0z1yWrr5QFc0dIs5DhNBJJQYQWvP2b+ha52HmdIVwhNpks6PcTuRAgIM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJSdg7NZjSUmK3ZadyI7mRUxQkDk9grNVIxu4UZJZhi4E+wxrsL
 Kc3WOl9R9c45O95D8IYRT63CGLVbweoRXxDeBStuXaxPRL6QVvSoYdaWPTXjpwZxPMTUxV/vIld
 7hJlEdBl07wvEQuFkjTLJl7TwxbESgO+NQcZphl8MiO6d5Sqyy1GY0g+iz/n21+M=
X-Gm-Gg: AYBFou2/Rz9PgaosZveT89Va2VfEzt51rBVMlUL19lstQdAANDNohmTBAJhybxq3fP/
 cav+cqy3jr3VELWcAXQEBqrSZ0cDatuDZO9IdpYqkxKXIkvrPDtzHOK5guNZIYySE8lzj7iyk9/
 U2WPLiMmrwb+L2nvGn8NpT0Zp9BGT4mWXj8V3yG4nKRBzx0bTbA/n3Y1g5L0FK9gircwW/tEMuX
 ByNNRfhmmiz696vBwmydvBPps39fv0G0Orvu78s3JUf+xrnPuFI1lMNmFZp8PT2N9iNLf/CpgFb
 +j3VDB34cz0El9VKETjMk4fQSTuOvRYX1TwVdF/owMbj6y+3HGZO21Xe+Ccj4lDgTBE6xI6hHFf
 62LtY7nT3yTgM2e2DKgpqoY0fWpJR/q76FGdI91o6KcDI+JLdtHYSBVfNanIsZvPg1ldVxL6QZf
 Ai6wWiID1u51mxTbhgwU5ttW+12ClbUXtyceRzF0VnaNF5zcyy8Mf2Jmunau2/Da4KOA9OVoVRV
 Q==
X-Received: by 2002:a05:690c:e692:20b0:8a7:6a41:12db with SMTP id
 00721157ae682-8ae94b359d8mr16701037b3.7.1791208553421; 
 Mon, 05 Oct 2026 06:55:53 -0700 (PDT)
Received: from strozzi ([66.193.28.125]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8ae328ee37asm39074437b3.10.2026.10.05.06.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 06:55:53 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Jerome Forissier <jerome.forissier@arm.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Sean Anderson <sanderson@brivo.com>
Subject: [PATCH v2 0/2] net: mdio-mux: Recover gracefully from bad parents
Date: Mon,  5 Oct 2026 09:55:46 -0400
Message-ID: <20261005135551.510145-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series fixes a few bugs I ran into when the parent MDIO bus doesn't
behave. You can reproduce these problems by running `mdio list` on a
board where the parent MDIO bus fails to probe (such as if there's no
MAC and NET_RANDOM_ETHADDR is disabled).

Changes in v2:
- Don't try to get the parent unless the mux is active

Sean Anderson (2):
  net: mdio-mux: Don't crash if our parent never shows up
  net: mdio-mux: Remove ourselves when our parent is removed

 drivers/net/Kconfig   |  1 +
 net/mdio-mux-uclass.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

---
base-commit: 2b8902913c19eb581fb0d567201c09b8fa46ac74
branch: mdio_mux_parent

-- 
2.53.0

