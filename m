Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFB5606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 04:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ggaCNatZ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L8GlB7YL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 962AF40539;
	Wed, 28 Oct 2026 04:39:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WKOb8uBvcL_L; Wed, 28 Oct 2026 04:39:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EB2E34053A
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793162365;
	b=FPSYQ0NTYEEGyDp5OJuaPqk1CZQPT6Pugxd8cZKb+9/7PK5Lw5gLL5/Uke5zT7pSnF8Q
	 D7E5+tny/p+bXSpuKO6I4Ijjhbqvj/CirFfvbCIxdYfYe9R4STy51pnDI7rE4DMTNqWqZ
	 koxmrb65UM08raaGBeRS8FIkgZxoPRgREdvCBCofbVgiz/jzqUtnwwfQlEpuytz4ZeywT
	 Gmy4/NerUwJ0eobYRvBiSY/uqDoeAOpWb8BGR2zKOuyKugnrEByB0ChoeM+B5fv/xY68m
	 jCp/Iqcw1g+KyWrSvkBxH/g0oPPlmiOxHTcFPpd3RDaYmyiPm9ideh+5mJGlgkhTlew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793162365;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jYa8b1LE0qYztWQvyfXx0h5RrdqEr9HkrfuV9DyNNfs=;
	b=ZmSDs7ehwA1wBpdcmODNDiOLMNZoPzdckibHvJ/xGxq53Kpj15GFHdhS5B6uR9g2h1IC
	 gjUYXI9K3kDkNWL3vnlRhUMDtxMcZ+3TpNHkXjfpNdACkczIvWn0C3pyDTC7loZ6AdOWd
	 h6SXfKvx6SjZb/9kSLFxlhpGGk9HqPXf5grFEFmC7E0igzTj9/ImCTpT3p/f6ffgrHZqh
	 ryCHe2q8uEaZLEf8lxlO8vtGKMUNWskW4OinXi95bxCQgaD4tK6GNYHodzWLYaemdGlGd
	 9SQd0HZGnM+xqxjf9YPfEYe0KLdWGgKAMtjXIIu6a9YOwlJwDdz9A8be4+55gtksyLg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793162365;
	bh=jYa8b1LE0qYztWQvyfXx0h5RrdqEr9HkrfuV9DyNNfs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ggaCNatZvuitRodm0wLfNCW/HIFzGlxcoySDmvPLI821CO7H318m8cY8SyKiccMpP
	 wuu5HxUg8LB3n1I0NvUDX+w+USXVT27y8KG6b4tZgdUw/ia2yUT2/eFkCep0Wj0yMj
	 Jw0SxTMEcEYHiTmffqtkbznyva42lpU3Pe6A0uPUKItLqTBK9aQln8RUCo/2VYM6MC
	 619hHc0BlbS+6H1XA5aFiyH205hahn2MtwsoqF8yuZbtaKGHKi6GmVCQuO7GFESxSg
	 U+AMKG+86IN3MOC2+N17zMbKlWPe0274L/S8N11KYCauKCyOnT5N9gDrT9g1VW53sV
	 yxAN9iFEIqnZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB2E34053A;
	Wed, 28 Oct 2026 04:39:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EF018D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 02:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E0C1580ABB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 02:14:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xolo0d03Y0Nf for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 02:14:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CB3B580AA3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793153674;
 b=U507VT8npb/+ketjl7HplfmZl1OqywzbWnIcfzvOwNusqP7wgJ2SwSAFMvYVjH3+ktM4
 CxJkIcIYo/XEGyNaTJrBZMoHGuGG3RvsSaxJz9A3tpbNSipvT9akxPlNG4Kkmh3LvZGhh
 fMToiZK9YnH7G9RFmlILmjA+VazHNtmtXqXaFjD/a+WyM3YBUign2uCmHLRaM8zUNDe7T
 Q1R16F8T4LPIHgA3Z5TP6rmgRI+SA2Ux4CHm+K5eS5A4vgC75qaLdnNYykZyB79nja3mg
 nK3+3tGWM81GQB0kksUMXa3D2cFUQbEdvvYBXGmhKjgSUjqfRbUS0y4LE3RxZWbEFeg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793153674;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
 bh=jYa8b1LE0qYztWQvyfXx0h5RrdqEr9HkrfuV9DyNNfs=;
 b=BSPDS1lyk8j64QuHzmiCZ82OcvbWPCqTSZDR3HNVuRk7dEfMC6QN/Js3WgpbyRMEyLg5
 F55ao6QulhtPs0vq5Ho5t5QYNxhCADQNm62bTIziBRZUq6KDmZmM9CpgbJAkG6qDrHFyU
 94sysgL7j3nyaXhgXxQ+YwJE6bxGTFvRj6wJ/ADZJf1chvxQbzq9h8qfjOoe3xTIN5Gqf
 lhggAqycXxbA5CqOmZloCIiq5VgYdJZJVx9MHej7uIUvokKpaf3hXLMLb2BodafoKC6+r
 pUuR7rRMB07+i9bDZ6v/1oGr6hcpdk1tQgBQecHD+Xu3CHdMFJ/aK2XoYlU9Xwiq3rw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 spf=fail smtp.mailfrom=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=L8GlB7YL; 
 arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=ehbello@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=L8GlB7YL
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CB3B580AA3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 02:14:33 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAD0984119; Wed, 28 Oct 2026 03:14:29 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 110EC83108
 for <u-boot@lists.denx.de>; Wed, 28 Oct 2026 03:14:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ehbello@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so5366965e9.0
 for <u-boot@lists.denx.de>; Tue, 27 Oct 2026 19:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793153662; x=1793758462; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jYa8b1LE0qYztWQvyfXx0h5RrdqEr9HkrfuV9DyNNfs=;
 b=L8GlB7YL7Mzs1IFEREDUjKqiKrfPsQzM8l7tA1QfVJcdzVNqVvM1JRtEOC3k0kDcO0
 urhCsUFFtAGg/MhBojckfG5WmP0S4Qk0rdmqSxXkqhePl/ROhhhjKCCVkIP/i2kkbGv5
 7KlOjEqPrKN3zS388ExU2ZSPdNQdpGfOgYatL6YUd2ll39VefAuBK8dwqjBBgGPVifuG
 butZQAu2EWtZ6EMkPoMeJ1nQ7kg6SXJNzsKVFKMRygNC850mEEIsyh0VYoYVzFB0MqNw
 t36CIfJX1NGnWS5gmMv98tQaSrPM7BdBJJxl9vj3GGcelFQ6g6Ar5Hx+TM7JmLC74V9h
 fBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793153662; x=1793758462;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jYa8b1LE0qYztWQvyfXx0h5RrdqEr9HkrfuV9DyNNfs=;
 b=XPlEr028C6YjPcpHYoXf/vCzuZhBg4Os0otX/mh1vqC2+xBxPpqs49galMGpct0J1U
 EQ0twzjy6Xs8cQlyJmCZ7HTekGgfmbbIGG4ZCW8Cl+mRLGOmwC4twLATj4G15dPxXGDy
 8oTNg2pPOSxbH8bfUhOr0vsSrzxnUaw/AJxMLAwjwrf4C2B0Ag+EOb52JoklDqEmI8zI
 Jn41CsMMobZJ/+BIWYK1IODbvLwsLhS+5tqfoWmnBmGd0rMmOm5yIs7KHKEZIuxNy8id
 1yOFpbQiM4A3C5JAmkYrWQeD2mcagUsVaocVAyehJM3TM4EIeOn7AwYGuOXMuwEc6CzR
 SZOQ==
X-Gm-Message-State: AFq9FYJ2qhN/2e/yb2k1ALRFk5sW7yZ0fi9zovoqHcOxVFROH2Uhh6xc
 EqZuQU2wBfV7I1DzB/Su42hT7bmOlJzMjjvRwXevLVqbdHor3Jmu7zmJ4ghP7Sf2TBM=
X-Gm-Gg: AYBFou1fF3RirMs1fEKLGK6m/TijC6ufyq+BtXZGtlD+b+V0k8uY5BlsAPCBQOO06oT
 impPMcvZovUM43dzHeH0zPO0/bxHlxZfeVHlIMdF6ZC9OOu6Se10YJHPcEMD6IDyj5AB2z31AnT
 l+Uy5Ob156z8VJQZ60JDnYsykAdl7hIW8yWnof4AdDrDJwVlk6abb78RXi/BYSPxtmiyLY0PNqN
 S4mhNqDHHnCer2TLHYCFToIXyUuHY8vdhmk2OQ1iuctCPrGG2/2F6kp8grCD0kod1btoKO2GphT
 EmJTvghZ7o7G9yL5Nkmi/xLn1sJtVsqRS+leJ56fG6l4S1XU+KmgjoE/Nhfmj4QIWQsf543Kj8q
 GvGSbSvD58arNiF/613JeF06r/h3694QqegXRMU26lj5J2eQDKBcN0eN6qrFBLltDaKPJtqPAZb
 0JWCFhCl5ZM7Zf7oYjceeO1ZOu8sPNrMHASoAg3ah9gxg56HkfcdIE2WcPAyRmN56dqP1uK/K9f
 HlSYY8BJwo/41v+oPyUrzfai2SIljOZp8R2DbW52GLFNBZFF1+nemVzWo6dDLJXFdFSej+6ciBq
 K37xrYPadTFVJu0lzpUSRY+MImItkKiydurIzE6axb9AG8YKAu1cp78QKBxDSIAgLorvj3W0kKD
 BeRpJbRbfCIgW0t6aJEUtpGsieOT2d24dEYiZ1V68ZdSP0w==
X-Received: by 2002:adf:e190:0:b0:48e:4ac2:52b7 with SMTP id
 ffacd0b85a97d-48e5d5ad939mr2597551f8f.41.1793153662291; 
 Tue, 27 Oct 2026 19:14:22 -0700 (PDT)
Received: from tachyon.internal (2.155.41.158.dyn.user.ono.com. [2.155.41.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc39b3sm26398607f8f.10.2026.10.27.19.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 19:14:17 -0700 (PDT)
From: =?UTF-8?q?Enrique=20Hern=C3=A1ndez=20Bello?= <ehbello@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Enrique=20Hern=C3=A1ndez=20Bello?= <ehbello@gmail.com>
Subject: [PATCH] tools: mkimage: copy the FIT in process instead of shelling
 out to cp
Date: Wed, 28 Oct 2026 02:14:15 +0000
Message-ID: <20261028021415.2439865-1-ehbello@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 28 Oct 2026 04:39:24 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rebuilding an existing FIT (-F) starts by making a working copy of it,
and mkimage asks a shell to do that:

	snprintf(cmd, sizeof(cmd), "cp \"%s\" \"%s\"",
		 params->imagefile, tmpfile);

so signing a FIT needs /bin/sh and cp on top of mkimage itself. That
rules the tool out of the minimal images where firmware tends to be
assembled; in one of them the failure reads

    mkimage: system(cp "u-boot.itb" "u-boot.itb.tmp") failed:
    No such file or directory

which names cp but means there is no shell to run it with: glibc's
system() uses posix_spawn and returns -1 with ENOENT when /bin/sh is
missing.

copyfile() does the same job in process, is declared in
tools/fit_common.h and is already called further down this same
function to restore the backup, so use it. Leaving cmd empty makes the
existing "if (*cmd && ...)" guard skip system() altogether, the same
way the auto-FIT path above already does.

No functional change intended: the temporary file ends up with the
same contents.

Signed-off-by: Enrique Hernández Bello <ehbello@gmail.com>
---
 tools/fit_image.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index b648e3e2..a3a05cb6 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -1654,8 +1654,10 @@ static int fit_handle_file(struct image_tool_params *params)
 			 MKIMAGE_DTC, params->dtc, tmpfile, params->datafile);
 		debug("Trying to execute \"%s\"\n", cmd);
 	} else {
-		snprintf(cmd, sizeof(cmd), "cp \"%s\" \"%s\"",
-			 params->imagefile, tmpfile);
+		/* Copy the image in process: mkimage must not need a shell. */
+		if (copyfile(params->imagefile, tmpfile) < 0)
+			goto err_system;
+		*cmd = '\0';
 	}
 	if (strlen(cmd) >= MKIMAGE_MAX_DTC_CMDLINE_LEN - 1) {
 		fprintf(stderr, "WARNING: command-line for FIT creation might be truncated and will probably fail.\n");
-- 
2.56.0

