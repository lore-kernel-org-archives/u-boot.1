Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B782C982D6
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 14:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6497960B09;
	Thu, 17 Sep 2026 14:03:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bqcHClUZDtJo; Thu, 17 Sep 2026 14:03:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A93AE60B0B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789653789;
	b=Vc1dMLF+R4TYRhqrTk6wHefDtwcEyqBPhfte4S0hCg5u/S9/e2vS6FZqAtN5vL2C8845
	 tkKQnSdzwsAf41oXd2u3b+oZzHO1cvehZwubjkroVqHneS/htEbpG/JVZ3dV7sdEcqJQF
	 Y1eAqSRsVx1lp2BrhdZtTQvkFg94TBDET5fBa7NuERMeJkFfIuvX5R1cxJmpEGa9tAphS
	 kLQDWhm4pJfYRAG7n6TAJL7tEngIccyFbgIfGRHD9DzoW2VSRs1nQOcn3PCaOdQoSEPYo
	 Zd5HM3XnPaEmytTFUpN12Qhrwy/wZZ/PpGnfH1jk9GrhXr5i2uCoI70QWeUTncy0QQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789653789;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=f//WOEMFk5wCSx67guXcH2xwJ31njf8Ghr0wQvS1t4w=;
	b=oH5G1fXk2+ZvIK+A8EpAnTn8AiKFaY+k4+B9oSzjHSrFUTgPMCIsO5hZFIXB4pcXiMK/
	 CY+/H2/UA47bVNC3rE+8PDhOwyPPVT+ml2eqwMLZlfI7XtWzduTQtKrcQHZuotjK+7pzn
	 AL9k+j00e9c/EZw+qgPTHnLC3rMwHnnb8/ON1KUDrDD6Np8zUrI6EOjyb2qtwjpZlZ91b
	 /W6wjAvDNJJxNVGxjvKly2VEnSr27qda7LD59vKum73EAcRfaf+VaBDY0YEXetMOBjqy6
	 kr4oy1HdmxfyyD71IputZ2dZgS4tTqjoGS19zOuHF8kvkKlSgI/f3jdOddvbyWaXPmA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789653789;
	bh=f//WOEMFk5wCSx67guXcH2xwJ31njf8Ghr0wQvS1t4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rcrFNxYwfEaCRHCP+b6ApwU/Z5gU+2jfAysCotlXYIHOmmJU+w41IIVF4n6PVLD2y
	 YxmPbB2tB+bte49kenWKY8b3CRTUDbrv4Fm6UPkdqLxtE2Z0jNqlc7nIYAgULnqIo6
	 s0TVwNonFfRw+RyN83YmNSfiiy8DtaX6akIkdQ3vNfmnZJunDZzZHYxlToRo4yDtgl
	 yORH8iQ2Jdh13hRm0uvB3LOEWnluj4dh27KcOz0o+DhTuNjwnArgHzi8l11fWNZavR
	 qCai7+iVwcjJ5oGTLG7ugjegeRLHCz3uqGM1Y5OAHCNJ7lDXuMe6PO9Q7IbWwQ+b+F
	 4rJOQpkMxqW5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A93AE60B0B;
	Thu, 17 Sep 2026 14:03:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 02E1D13D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:03:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DD37280A54
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:03:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KoHUmU4YXhJx for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 14:03:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0949F80F3F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789653787;
 b=EgEV2ACLAlWEhCWDKybxmLVSqO95R33C9QqSRL6iARKfoN6D5wNBUeGo4vB/1avS8+pR
 3vrkMmXT99tuZIldPE3Xyc0P/2sei9xMFHKMIX30ohIv4zbpJ2+G8VZqb3OsihU/X3KsY
 RQuPu0W0/CXgg85A4buDev/maQ0Q/jtbGfRR48c/E/4Eg7Lh6nlk5pYM4gCoK9kQNkMJN
 iVTm3ptzgwYZa1Pfb0Esc9qDi0+TBsxtF4UTGl2CSiFaFA6wste7YMEv/mIu2lR8R4XZ8
 devM7Eg9g2tLdkP2dhMxVYr1SDrs8RwF1qMzOdDC1IbHhfGTaqzbhMWwpwPZw0vdK1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789653787;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=f//WOEMFk5wCSx67guXcH2xwJ31njf8Ghr0wQvS1t4w=;
 b=qFIfWcsm01jwpELaWnGLs1v9XiHraHOtM6MdI49iHnlYw+xxpCsAMDnOlpGy464X9w+d
 nG+JJve8qoYHunmME5ukX6FQmLBJeqm71PD9z0IaU0S61WjHmVxl0HR3RHUJYIjpBJ0di
 Mv5RV8iKduoURatqcV8ICkSzt/sGx1ckcHdLZSru8BCforka1VXMgV9lwv6h0g1n3fzV6
 QfDrzb+syxQr5tJBAcf2P8AEGBskLFt3tPQtSE9ntx1l5Iv7bqu/7hsCnmnYTQasRD29i
 rg580QJL+Vrd9dVp8ddNuotH2kj0zT1znVH/yYatv4xrQ6ZLvPYc336NE9QLrpbBl6g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=leVhzJka; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=leVhzJka
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0949F80F3F
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:03:06 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6356f6bso742916f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789653784; x=1790258584;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f//WOEMFk5wCSx67guXcH2xwJ31njf8Ghr0wQvS1t4w=;
 b=leVhzJkalzyPsc3cWwaRYiiT6kZHVFs4rDGihfE3M7PCQm1po5e2M+tinFlU17AS2t
 2LXk1TU47Or2ZXasqxb17IpWStUPgR98Fykb7lgSXiGdDdpYeLuhrJ58qdsKNyu9KrjF
 jBE3TSaBZ6d7+Ua/Aja+1kgQvj5XrS62MHBV+1yJKI+X9x9CQijXPf02hH1h/LrKAa/t
 NFqhNC729SZI6PiTsJaXJGpXfPbtzwUlp9K5xdFBA1ED7zOvy651BBBjOVL796vdwMoG
 H1HtA+cFpp9sw9CNV8CdHsATkXdbSEjrSuNA/CLD7vzjTyM8dJJjlmahytIEjcpyCKJX
 0mlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789653784; x=1790258584;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f//WOEMFk5wCSx67guXcH2xwJ31njf8Ghr0wQvS1t4w=;
 b=j/tMht1MkPaCFdETd7G+rS1u1+ldzE5BaJ0DLxK/WtrgYKMTTmxLDHmYDZsDJN+3Qe
 3WSFe+y7Vys/WpBvmzItOInbrBbfkGZyyv3+/uBZNVFRDpLTDXUzf3+4LqTHEOo2iGo/
 MXMSEMfwcmFEaLcu57PyEEu8P1qNGbs6r6b/Fzqa5e4Vbd+RNktK3QEdWP6bZXWGzafA
 tqZKoZ8OSl0r4tnydgO9ObYjEA7l/z9Owff3oFmESuZlSZNgzvzcJUyAyHgr2urBY43J
 1lSAsmOHNjiXCQCesZhtzj8aCP6mX/GyDakxGiyLwKmlKuPVqcaj4GhEKlE5ANXHXls6
 HftA==
X-Gm-Message-State: AFuF++nEsJfKKMNSFo8VihuYEK0Efa8CqveDMBeUCWNPbSiNJubGAkC5
 btQ7Ci3JGGCOvKvaLhSG/TKF3NX9pMKrRi5WDS2PudvTZ/tkugZi1byXzCern+ID8T0=
X-Gm-Gg: AYBFou1oUmQ9w6mNEixZ167D73PAjfft+84QQLaozVcl8/k96sMuuxwjXmqSTbMMiKS
 7Hj/WCmb0aK3AgfKM2pdtvIEM0gyvK4+OjxXXCrxl9EYDoKnCpxc4JO04Kww6m0jAxHQoBuMrv5
 lGkDg8jnZEEn+d9fEuKAKxWqYSWg6YWcMgtYnYoPKhkvuP4ogy9/uHtAcFgnmNqDP2QsQ+Ce6ja
 JL40xsRBTPKPCl7vu4eiMdwN1ECddC/ob3ftuPJ1BJ0n02N6C280a3lD1cJ8Du6833RlNqUCB+p
 lErnzWkUOZSi/wpRQctLvvfpKPLUBXoAbvJNCDQxxhRMSmtVLKl28638p4HHYSpWNWQkbi/jlhG
 xROOeLOqmqWZ9Ri9Wv8RuK5RJURjEkzBmrVImTyoKgEauRWFYTLs4oomR8W7lxMxJ/LBK5x9LyQ
 q4s11LRRXndCEGmBObN8J6e8ZF/laWqZKlf/zpzFcemD+8ou/fKHC73wEuUBykfKhOmaMhp2bYG
 moi27tNpVabk0B0bOvQ6TAoKNc+5/q9+E7CxUpCPTwYYUOP1En3
X-Received: by 2002:a05:6000:460c:b0:486:e6a2:2d7c with SMTP id
 ffacd0b85a97d-4870cf445a0mr16777645f8f.15.1789653784372; 
 Thu, 17 Sep 2026 07:03:04 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf344fcsm16893905f8f.26.2026.09.17.07.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:03:04 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 17 Sep 2026 18:02:27 +0400
Subject: [PATCH 06/11] test: spl: Keep the payload create_fit() is handed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-fit-compression-v1-6-7985ac56ee9e@flipper.net>
References: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
In-Reply-To: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1904; i=alchark@flipper.net;
 h=from:subject:message-id; bh=JSM3sluxSzUtFvuWVX6Vbzp5M44pdB0vsnm9usrDods=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSt/vT78ftzmUrm+kr8S57/Z95fYfL/e9fT2czH/Kyfd
 3rY7Hrt1TGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUbxJjZNhqd6D6wqWCTYmHHjB6qsVoL3xa963qzOLy36x7LcvZrC4yMhx6saG
 HQWOTpvima6W7C+Icz/VHyvc80rafekjVqqBvDT8A
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

fdt_create() clears the whole buffer it is given, and for a FIT with
internal data that buffer covers the payload the caller has already
written at the offset create_image() told it to use. So every
FIT_INTERNAL test has been loading zeros and comparing them against the
same zeroed memory, and would pass whatever the loader did with them.

Keep a copy of the payload across the call.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 test/image/spl_load.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 334ec77b18ec..94ac3a16b863 100644
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

-- 
2.55.0

