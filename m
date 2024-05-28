Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CBFC27C43
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 22:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EA7C8857C;
	Wed, 29 May 2024 00:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OYHvx0cE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70C7588571; Tue, 28 May 2024 21:20:49 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ED2688543
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 21:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=edmrubino@gmail.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-62a0827316eso12431727b3.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 12:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716924046; x=1717528846; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0cnR+h6jRju45CufTGDH5gSNHmNWcpRJH2/xITMZY9I=;
 b=OYHvx0cE6rnZdM9sL5S0FOpQHI82rFXV6yWExPxs/5IQn6dJ/g5wJc+5oyjsCmOF8H
 ba4ZC3P3JCWqYCp0qgQBezpcbsgUZBq6bjwvTnD78IdQd1GeB3c5+8JvoGkKX6JTzs1o
 y7XfuPzhwJPyXEaR2O7mYZdgqCEUWo9jhbosvmFhjZ6p349dEeD0n7XFGp3VxGKW+Pjm
 qcBMMXXgDEqSFEdd0jYHZAFUUof/VzSFDDWMcaPLokVBp0+K2BzNwOkXJW4yP8ROwb8n
 U+BLkgi9+OiekmvlVf4PYD12u/H9kLXq7PtEfp6Vs2oByR2kp3Dqmed/Q8/Vm3nosJqU
 E6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716924046; x=1717528846;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0cnR+h6jRju45CufTGDH5gSNHmNWcpRJH2/xITMZY9I=;
 b=dOsmcx7vrRm5PBNxQx3CniMb8dF8V5UgNxs1NUOQU4+Rrjsd2xMVeZ/t/dw7icFnvD
 BsZXoOZ/o6M9DoSO8kl12ERQ1naw3m7sLpST8/4869Zw62K9+MnOTtq0YBWwAnD8l6iv
 8YMybhwRJDpEtVlGoIKC5qbUuVsbByPwFLAjk80iPtYuVK5Blxuds4sqGWt6xj5k2giO
 ktIYJsUYOgWIYxlK721si70pSG9aWfuXLknBuwV5+ZG5OZ1dKFJYhqeKDFx6W1jYPi19
 GeG1cUaiwV5XDUDymh3IgSoOVi6zM1rqxN6Ka1gwF3+sJRBaKtJSQQW4lUCWO58MWGRp
 +hZQ==
X-Gm-Message-State: AOJu0YyPOwXU16bLUFHamU719h0UT4J7a4/ih/MnFcDaEQNPFzh2xPlX
 zTVugegUb4E0D8OrFJGCg2KMknvavFUa0VQlemp9uC6J4Bfqr/gn7CwsLK29NjtoK96g99KKV/G
 jLPLPb/IGEfmE5Xh54wR4zIZ1jE7b7LZm
X-Google-Smtp-Source: AGHT+IFHfNYMCzECSbtapJgyI7/lEo+jY8+mc4KT8E1Zf24WeSwtGu49EVXHzJBZdc9O2iZTldECCaQih07carpM2jY=
X-Received: by 2002:a81:b649:0:b0:627:dd90:daed with SMTP id
 00721157ae682-62c59cddb46mr8840307b3.27.1716924045933; Tue, 28 May 2024
 12:20:45 -0700 (PDT)
MIME-Version: 1.0
From: EDM Rubino <edmrubino@gmail.com>
Date: Tue, 28 May 2024 21:20:33 +0200
Message-ID: <CALTvn=EEr4u2FvCcccQ412+xQZMWqbstuj_fihzZP7z8-fue4g@mail.gmail.com>
Subject: Fix splash screen display
To: u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="000000000000dd61bd061988873f"
X-Mailman-Approved-At: Wed, 29 May 2024 00:21:41 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--000000000000dd61bd061988873f
Content-Type: text/plain; charset="UTF-8"

The attached patch file consists of 2 small patches.

[PATCH 0/1] Invert the order for calling the weak function
"splash_screen_prepare" and checking for the "splashimage" environment
variable. This allows us to display the bitmap in bmp_logo_bitmap without
having to neither copy it nor specify the "splashimage" environment
variable. The user can implement its own "splash_screen_prepare" in which
he/she sets the "splashimage" environment variable to &bmp_logo_bitmap.
This is a kind of "hack" and there should be a way for the user to specify
that he/she wants to display the embedded bmp in the bmp_logo_bitmap array
and, in this case, there is no need for the "splashimage" environment
variable - eIther a config option or some other way to express that this is
the intent of the user.

[PATCH 1/1] Fix the test for CONFIG_CMD_BMP to CONFIG_BMP in order to
display the logo image. In fact, CONFIG_BMP is set to y when CONFIG_CMD_BMP
is set so there should be no compatibility issues. The user should not have
to make the "bmp" cmd available in the u-boot CLI in order to use the
splash screen.

.Best regards

--000000000000dd61bd061988873f
Content-Type: text/plain; charset="US-ASCII"; name="u-boot-splash.patch"
Content-Disposition: attachment; filename="u-boot-splash.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lwqs4u500>
X-Attachment-Id: f_lwqs4u500

ZGlmZiAtLWdpdCBhL2NvbW1vbi9zcGxhc2guYyBiL2NvbW1vbi9zcGxhc2guYwppbmRleCA2ODIw
ZGI2ODNiLi4yZTRjM2ZhMDcwIDEwMDY0NAotLS0gYS9jb21tb24vc3BsYXNoLmMKKysrIGIvY29t
bW9uL3NwbGFzaC5jCkBAIC0xNjQsMTUgKzE2NCwxNSBAQCBpbnQgc3BsYXNoX2Rpc3BsYXkodm9p
ZCkKIAlpbnQgeCA9IDAsIHkgPSAwLCByZXQ7CiAJaWYgKCFDT05GSUdfSVNfRU5BQkxFRChTUExB
U0hfU0NSRUVOKSkKIAkJcmV0dXJuIC1FTk9TWVM7CisJcmV0ID0gc3BsYXNoX3NjcmVlbl9wcmVw
YXJlKCk7CisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsKKwogCXMgPSBlbnZfZ2V0KCJzcGxhc2hp
bWFnZSIpOwogCWlmICghcykKIAkJcmV0dXJuIC1FSU5WQUw7CiAKIAlhZGRyID0gaGV4dG91bChz
LCBOVUxMKTsKLQlyZXQgPSBzcGxhc2hfc2NyZWVuX3ByZXBhcmUoKTsKLQlpZiAocmV0KQotCQly
ZXR1cm4gcmV0OwotCiAJc3BsYXNoX2dldF9wb3MoJngsICZ5KTsKIAogCWlmIChDT05GSUdfSVNf
RU5BQkxFRChCTVApKQpkaWZmIC0tZ2l0IGEvY29tbW9uL3N0ZGlvLmMgYi9jb21tb24vc3RkaW8u
YwppbmRleCBlMzM1NGYwOTJkLi4xOWI5OWIyZTZmIDEwMDY0NAotLS0gYS9jb21tb24vc3RkaW8u
YworKysgYi9jb21tb24vc3RkaW8uYwpAQCAtMzUyLDcgKzM1Miw3IEBAIGludCBzdGRpb19hZGRf
ZGV2aWNlcyh2b2lkKQogCQkJfQogCQl9CiAJCWlmIChJU19FTkFCTEVEKENPTkZJR19TUExBU0hf
U0NSRUVOKSAmJgotCQkgICAgSVNfRU5BQkxFRChDT05GSUdfQ01EX0JNUCkpCisJCSAgICBJU19F
TkFCTEVEKENPTkZJR19CTVApKQogCQkJc3BsYXNoX2Rpc3BsYXkoKTsKIAl9CiAK
--000000000000dd61bd061988873f--
