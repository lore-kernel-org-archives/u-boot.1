Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D750CA5FE4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15BDB8148B;
	Fri,  2 Oct 2026 21:33:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0eFRTNv1ab0A; Fri,  2 Oct 2026 21:33:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 50DC88145E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976836;
	b=bkIzllVGUK4VWGjwwis3AjHrsQ56mSZ2crSiwapVuJUXSLsNyvgKiit1PKoi4855VYwZ
	 /ongfAhA6Y14niiBQ0OswZj3IdJTCCTWidAOv8NhYN6bhJdQDw91G0VO0dTdEEv/kcpwM
	 Cbb7PSqiVthh2VnV7XrN4RiCfkfkdH4+bKt8xWUbGGehxO9On2gWSz0EOI74PLqYN2ubV
	 eIVQvwRv5jYJesfcmmx7D0mqMCIQKOdcuFldIavEtWKFYdU4wzkV6AnlfoW19ZruJAtkJ
	 idcKsSbDUEfYfqskmwYuCMAcff/PQmkfAXFsk++3s+HPqx/QamHra/jAVl8q4z/SCZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976836;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1gTy9i+7J4jFY5s6fMi/sYUVuaVfesKxz5Rtr/5yvto=;
	b=JvH55YUTQdqjPUSOBkO4Nw5ZC+g3MZhBoNpBRW1dbeQiP/60fM6Xl9YkD7ftaYnO3y78
	 5QQULAzg/+gFQ70DtP9s5sI/vbY+f8+h1UstLecvbwb6OH6OiV1rnsfCdBToZOOt+Sw0J
	 G9rHscl9qkIA+JTc3ckFrsvNMgFbe7tq51UlmxPrnQTPjuj4HfSBe4Y3uzNH/D4zB4Fa2
	 YLm2HB3zb+kek+TI8W6NqWe+aW3+bhvpIspE7mrm8jALL2excCk07HXj5zbZpXou8Md21
	 1oBUNfrCecI72uJtmowt2eA2F6R84TL7Q3sP7nuHWzDqttq/5OAdep4qUaiYHgGHiOQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=uRu9TF+s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976836;
	bh=1gTy9i+7J4jFY5s6fMi/sYUVuaVfesKxz5Rtr/5yvto=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AjUcthuxz5SsZSFNkNMQowaV8MmfdH5NzbWyc5Wef8To6T3XM1lnbY5HpLrV41p6N
	 QaUVAeBKqs/Pjh0UWs1V8HGvcwrq94d38bXg4eatEf9LFeAtPIPKyNg7jK+kAaW/Pm
	 RZ0r4fh8QaDy3QqIsUOr+6poRBsErYHSunXlOeuj22KwHVb0Y145Ux3f98o1RVsWzF
	 o5r6k/BYqiA4ObQy6PwVuY5IHseiJr73FievQVB2vd+1X5TKHKOpWHdNkHjVQoJl0C
	 SeCyr8k1L4k933WD+FIJLrzfHfLkrTbJHb9KGG58kw73LbwFEMfwwrxA1NQv76+pl6
	 Bm6Fr7IjenTnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50DC88145E;
	Fri,  2 Oct 2026 21:33:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 61BCC34E
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F39F813D8
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:33:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rnWN4gkfs4BE for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:33:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 942C9813C5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=79.135.106.119
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976798;
 b=DADtGD+QQbIMZWRt/Arq5uNDG2O/kV7g0MQlKJyQ2N0BxG4ScJxaWOykwJ70O/cQgpcG
 cOTtCw1kbnd+3l045BIb9LdgsjsW1D5uSmB5+7UOLEnf7/2mLQY6n6MaURJ3IHmQwpoqu
 BEvgj/prFXdBOsfHqA1qBrH7Z6r2C/qx7d1Zcj6yd8w46O0Ljcjz+MoD8vpVf11nHnacg
 GLo4JzhELjzgbwXd4K9pxYM9RsxO9HcRR63KoamOSvUeD5SK0tKY/R3DbjmcCCAQlthKc
 4LN/8lI2GzND9s8MjmjpCBp7K/SSeNX4JuURcP+Kpz52EBNDbswfr0/lq3iOPb/0umg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976798;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=1gTy9i+7J4jFY5s6fMi/sYUVuaVfesKxz5Rtr/5yvto=;
 b=OZ0GQxBb0jqht51jtqmVSyfsj/P/jlOInEH0JfuRAnnyxJ3crm+LR1SBpzAqPQZc0/Qf
 G7llckCN8Jfv+lAGKxzRASLY2T0Bes4Xjcq7HsupKG18BlqJps8pGPvNmYw6ic/G8z7bD
 lALG76mvddMJO71QunBwWUqWFY3bWLHv+FXanqHcT9K4H59Jsxz0s3AXu6ZmNglNyeRVL
 CFgqwSDwb1OZpNDKvVz7F9Q6oqNz41v2Sxcl/0XFHZPSsl0gy4Elm05Dc953KoVdy1HOi
 XdohKrCjLQuvipD/APlovp7r+c391yZGi5YeM9EGCfe5DpXd8mkRKP+hwylLVcb2Vow==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=uRu9TF+s; 
 arc=none smtp.remote-ip=79.135.106.119
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.119;
 helo=mail-106119.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=uRu9TF+s
Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch
 [79.135.106.119])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 942C9813C5
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976796; x=1791235996;
 bh=1gTy9i+7J4jFY5s6fMi/sYUVuaVfesKxz5Rtr/5yvto=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=uRu9TF+spY/p+QZCdvVsm3AwmFAq3si3SGauoVx7Hjs5HREMP0cCHxr3bGYHZjA5m
 Arwdjb6GbxAgoyqxkW5lEpATCOBCxt11JUyz5/ul7TmM4SaVx3iF1Xz6lu34HskjTj
 9zZQK+uj9Q7pzYucRUknCMnUFqwd3sMszTUjkqm1Kapll5jIHKqAk6yeWo0qf0aahr
 viRBBu180b9sMVM+I4CiHxAGttcia721xEYJgUybXXqOReovEcV62trSPE8Gs2NhSt
 vJLfK4V2e1a0ido23k55BFm6/46srPaopSeoSTrg5b1Tl33lFRVQ+vAev49ykd3Jtn
 wv7/T4Ap4LVuQ==
Date: Fri, 02 Oct 2026 21:33:10 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot-spacemit@groups.io
Subject: [PATCH RESEND 2/2] spacemit: k1: fall back to the other boot devices
 in SPL
Message-ID: <f492bf72faccb8ea1b91b77e2a28a9ca2caeb40a.1790976767.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790976767.git.DaveWK225@protonmail.com>
References: <cover.1790976767.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: bd860db7e5d85bbf2a83f8543f27df4103fc2a28
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:33:50 +0000
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

spl_boot_device() derives the boot device from BootROM state: the SD
API pointer the BootROM leaves in SRAM, the boot flag register, and the
boot strap. Not every BootROM path is covered by that. On the OrangePi
R2S, for example, the BootROM probes a card first ("try sd...") and only
then loads the FSBL from eMMC, and on the OrangePi RV2 it falls back
from the card to SPI NOR. If the detection names a device that holds no
image, the SPL stops with "failed to boot from all boot devices".

Provide board_boot_order(): the detected device first, then the other
MMC controller and SPI NOR when this SPL can read them.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 board/spacemit/k1/spl.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 96ee4449c4..cc0e26bb02 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -498,6 +498,32 @@ u32 spl_boot_device(void)
 =09return ret;
 }
=20
+/*
+ * Try the device the BootROM booted from first, then the other storage
+ * this SPL can read. The boot-mode detection relies on BootROM state; if
+ * it names a device that holds no image (the BootROM probed a card before
+ * falling back to eMMC, say), the SPL still finds U-Boot instead of
+ * stopping at "failed to boot from all boot devices".
+ */
+void board_boot_order(u32 *spl_boot_list)
+{
+=09u32 fallbacks[3];
+=09int i, n =3D 0, m =3D 0;
+
+=09if (CONFIG_IS_ENABLED(MMC)) {
+=09=09fallbacks[m++] =3D BOOT_DEVICE_MMC1;
+=09=09fallbacks[m++] =3D BOOT_DEVICE_MMC2;
+=09}
+=09if (CONFIG_IS_ENABLED(SPI_LOAD))
+=09=09fallbacks[m++] =3D BOOT_DEVICE_SPI;
+
+=09spl_boot_list[n++] =3D spl_boot_device();
+=09for (i =3D 0; i < m; i++)
+=09=09if (fallbacks[i] !=3D spl_boot_list[0])
+=09=09=09spl_boot_list[n++] =3D fallbacks[i];
+=09spl_boot_list[n] =3D BOOT_DEVICE_NONE;
+}
+
 void spl_board_init(void)
 {
 }
--=20
2.55.0


