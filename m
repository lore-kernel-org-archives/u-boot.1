Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C049CCD68FE
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 08:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DED4786C67;
	Tue, 10 Oct 2023 10:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VejsVYcx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7448786D20; Tue, 10 Oct 2023 10:16:44 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D6FF86C3E
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 10:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=monakov.y@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50336768615so7016135e87.0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 01:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696925800; x=1697530600; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:date:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=g7EwwQJ7BjJ+bwGYTscXbknLXbBOzV+sJpimFYvoqo8=;
 b=VejsVYcxnOVpBGKWupQqtaK41h8HnPL6aEJF2xOwdK/UOzVmF0ArCE15p9JsTv382u
 6Dvj7vDBYy6buY6oGGc1ScLwKQ7ybmAK89xvpDKZcZ8B4Zpk+OTFRes+0ay52Z4v6aA/
 4zxD8Gm+8MjYY7rML0VnAp0QcngHpw6Z8nwMMagYh3bdrlWBTLZhhdMP6WDG4V9YUrRD
 jyfR701WUyvGJXFIATnni79SL1aG+mOExGqEreIlV3VCOTqni5u0cnGELMMkXMwKtxvE
 f2LvN15Qqe78ZWDT3ndRDDbsQUU+yYvl6PG18CYTFHzmlXYCk0uZoQ4ShDjZetcgKlVd
 8EBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696925800; x=1697530600;
 h=mime-version:user-agent:content-transfer-encoding:date:to:from
 :subject:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7EwwQJ7BjJ+bwGYTscXbknLXbBOzV+sJpimFYvoqo8=;
 b=wBmrsHqfdPXfGmQbYWz9WX1aoh/p41ybLcdRatgOSm8ddn2+cUQUF2FQMVCoCyg6ib
 DtzKlDAD/esi+JqmBKIMAUXpmr5g2MQ3eTg+Cw1Ow4wIC6fehKMHacyDDxLFrGvtjETH
 M/fLv1WmSavXBca7FxqC/UXVeLmGLXz4lr/u18tU1j5qkctVHgHA/vjfpCt7b6B+kR4w
 g+H31VV4HbE7tU2gS1tJcWMdH6/RVaEFqMo+ZM14tUF4XMr4vDo6235gtH42hyi67xJM
 qhdmYAXgjFIMjPl4ACSFlfuPzMRAbnVk+LVvb6lpUzKxbwTCI8F/4bb04uSUUPN8oSkl
 N0xg==
X-Gm-Message-State: AOJu0Yxl5qHKuHiXqkFuwyYzvtORUR+lEQP7IU2ERZ+PtWDUMxWiVqz3
 LUscb3I0pDtT83k6gNC6C+eNyM7fZ7KaxA==
X-Google-Smtp-Source: AGHT+IGIeYVYjZVJH9xSuRr7Kog5nvtQQvdms1RLtU7YPbwhbwtdo9xvV09vRmj73fm8XueYF2BjvA==
X-Received: by 2002:ac2:5dd0:0:b0:506:926c:9b0d with SMTP id
 x16-20020ac25dd0000000b00506926c9b0dmr6516192lfq.20.1696925800264; 
 Tue, 10 Oct 2023 01:16:40 -0700 (PDT)
Received: from [172.22.33.160] (109-167-193-19.westcall.net. [109.167.193.19])
 by smtp.gmail.com with ESMTPSA id
 d16-20020ac24c90000000b004fe5608e412sm1705928lfl.170.2023.10.10.01.16.39
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 01:16:39 -0700 (PDT)
Message-ID: <775fa336fa5bfb2b9e1e892ee631bd743ea12364.camel@gmail.com>
Subject: [PATCH v3] cli: Consume invalid escape sequences early
From: Yurii Monakov <monakov.y@gmail.com>
To: u-boot@lists.denx.de
Date: Tue, 10 Oct 2023 11:16:39 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
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

Unexpected 'Esc' key presses are accumulated internally, even if it is
already clear that the current escape sequence is invalid. This results
in weird behaviour. For example, the next character after 'Esc' key
simply disappears from input and 'Unknown command' is printed
after 'Enter'.

This commit fixes some issues with extra 'Esc' keys entered by user:

1. Sequence <Esc><Esc><Enter> right after autoboot stop gives:
=3D>
nknown command 'ry 'help'
=3D>
2. Sequence <Esc><p><r><i><Enter> gives:
=3D> ri
Unknown command 'ri' - try 'help'
=3D>
3. Extra 'Esc' key presses break backspace functionality.

Signed-off-by: Yurii Monakov <monakov.y@gmail.com>
---
Changes for v2:
- add tests and reword commit message
Changes for v3:
- fix indentation

 common/cli_getch.c  |  2 ++
 test/common/cread.c | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/common/cli_getch.c b/common/cli_getch.c
index 61d4cb261b..0ee7908777 100644
--- a/common/cli_getch.c
+++ b/common/cli_getch.c
@@ -46,6 +46,8 @@ static int cli_ch_esc(struct cli_ch_state *cch, int
ichar,
 	case 1:
 		if (ichar =3D=3D '[' || ichar =3D=3D 'O')
 			act =3D ESC_SAVE;
+		else
+			act =3D ESC_CONVERTED;
 		break;
 	case 2:
 		switch (ichar) {
diff --git a/test/common/cread.c b/test/common/cread.c
index 2fdd29a265..4edc773960 100644
--- a/test/common/cread.c
+++ b/test/common/cread.c
@@ -43,6 +43,12 @@ static int cli_ch_test(struct unit_test_state *uts)
 	ut_asserteq('a', cli_ch_process(cch, 'a'));
 	ut_asserteq(0, cli_ch_process(cch, 0));
=20
+	/* unexpected 'Esc' */
+	ut_asserteq('a', cli_ch_process(cch, 'a'));
+	ut_asserteq(0, cli_ch_process(cch, '\e'));
+	ut_asserteq('b', cli_ch_process(cch, 'b'));
+	ut_asserteq(0, cli_ch_process(cch, 0));
+
 	return 0;
 }
 COMMON_TEST(cli_ch_test, 0);
@@ -80,6 +86,12 @@ static int cread_test(struct unit_test_state *uts)
 	ut_asserteq(7, cli_readline_into_buffer("-> ", buf, 1));
 	ut_asserteq_str("abc\e[Xx", buf);
=20
+	/* unexpected 'Esc' */
+	*buf =3D '\0';
+	ut_asserteq(7, console_in_puts("abc\eXx\n"));
+	ut_asserteq(5, cli_readline_into_buffer("-> ", buf, 1));
+	ut_asserteq_str("abcXx", buf);
+
 	/* check timeout, should be between 1000 and 1050ms */
 	start =3D get_timer(0);
 	*buf =3D '\0';
--=20
2.34.1

