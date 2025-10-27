Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB7FCCF9E9
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 00:37:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A7E982E34;
	Mon, 27 Oct 2025 01:37:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nVbFupry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95DE2832AD; Mon, 27 Oct 2025 01:37:47 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2720680422
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 01:37:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7815092cd0bso48975507b3.2
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 17:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761525464; x=1762130264; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/NS5bZoh1udk0cvouriHXuWNlZyiKNBccBjqzaoISGI=;
 b=nVbFupryG6y6eKSUudmhFX4eyf6Iio/sy7ApCTe0gR/tJBGjEv6yMZtfhsG1SgZ/jF
 OOxcvmvPJ3mDuavwcd+cj4kqNa3xBjJafQCSVQR7vagf0aMGyvH0/tZ9Jyx7KhsoJEA7
 1QFNEzRsQPfWvcQ+Y9FRkMiN/jgkrCZWFf1bl1qrt4aQOnEzoPbnw3vNImxuFj3In46L
 bVfegCf7gHOmDqMUtGVFwpGNdvyWn0tibu8Ge1qYNMq/f/XmQUrFS6reGqt1WGzEa56r
 c1+DCdUULOp7TLv2n2Uy2AbKnbW1MuLLwGRCD8GC1p9npscqroLY5uTdpiUBagTvnX4Z
 cQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761525464; x=1762130264;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/NS5bZoh1udk0cvouriHXuWNlZyiKNBccBjqzaoISGI=;
 b=TfR9f1AhUXyAVcivq29Wo0c6xtdd6DaBf7A0SUtjuz8oSKTDQ7QKpKWKHFRZKUclBn
 reijSTXtYCjVYwbSQgqh2R+HJcLmKJnsipOm2/DYpEWi4R5kfvLTm1nK6cJe5lblWL+A
 zWh4UP5UNaV1iJbxL25U7iUQcycKmC9277QdwI/UevUqY6rDcnIlMLDvYbfs2MTdq5dO
 VfQM9ytD/A4BChCKOGIIacS+EtJmPnPGtgngO9KJcEEyOmbdayliJIksHHYTS1SSDCqe
 uIB5JjGmboMLAitGpH2gWPjB0BDizHPW5ZlnxEbyFDkYUYGl5u94dfI2ZojbKonBpzpq
 Hhsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUZugVCotO57nXeWg2LmI6MC6fPWZ3NxlzvTjiVSWk+1pQS06DjbRJLj7CcYgFqitpV0SzACQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxGVNlr/zv4qu0KbsTbWxniVd5ooLi/MRQ6LZFiVRh35HLxH8Ru
 lOwCtPxB3Dnv4ZMqOVg6Iv6Y2KTKXdqg93qDvPvjNSWq31sDa44lsONwvsDMh+8PWQijFDKw7UM
 37HAdlYYUW1W2Xuknge7T5lA4fm664MRdVU8B9dpXi+HAh/52maMT67k=
X-Gm-Gg: ASbGncv4zQxg2qLh5YLSmpKoS89zFfsaiYdcOJAJiY39L6fPgF7wVe0Mbaf9Fj+9Sqv
 rle2u3id01KpVFu+UDb2pXml0adRsuH0iruR9t6RFUbKnFpUgxHUNSeLmZxwHVYyNhI9Dsn99xp
 cncOccp0ly6yHujM2SQDAUdoGhIaRFu5yUahGTAjzy45Em71oY2F4+qrUFLnQJrsl1UNV8PR+E9
 3jGBwljiV+FeT8aJ5GRy9UussS4Au4hmkgOmLDFS2mJYnjv9eklvrl6S4Y+slKjVOhjyF+Tcdne
 uhIEmXpkz05h4vNPVbDzMPT3u4tsqg==
X-Google-Smtp-Source: AGHT+IGTEOI0a6MOpdeoCMn4d2VlPSphv8U4w+vrFSfEaU28S8CekDkHCjaiDw7MACF9ZM5SGAgxiFPYTS3LJ6a9tWI=
X-Received: by 2002:a05:690c:67c5:b0:77f:772e:6229 with SMTP id
 00721157ae682-7836d169afcmr564502417b3.1.1761525463842; Sun, 26 Oct 2025
 17:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251027002458.16741-1-semen.protsenko@linaro.org>
In-Reply-To: <20251027002458.16741-1-semen.protsenko@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sun, 26 Oct 2025 19:37:32 -0500
X-Gm-Features: AWmQ_bk_E3xYJdwykpRnrnctYsmSBhtaQ2eNoSJ6dzmH78o4sxqjAFrPs9xf_aE
Message-ID: <CAPLW+4=EFer-nSnh-yKbAHU9o_GG2bJCL=KEu6ONuhr6+1RODg@mail.gmail.com>
Subject: Re: [PATCH] autoboot: Fix inconsistent countdown output
To: Tom Rini <trini@konsulko.com>
Cc: David Zang <davidzangcs@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Oct 26, 2025 at 7:24=E2=80=AFPM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> Commit 5f70be08b015 ("Fix autoboot countdown printing wrong") introduces
> inconsistency in how the countdown is displayed. For example, in case
> when BOOTDELAY=3D5, the next output is observed during the boot:
>
>     Hit any key to stop autoboot:  5
>     Hit any key to stop autoboot: 4
>     Hit any key to stop autoboot: 3
>
> That happens due to different printf format (%2d vs %1d). Moreover, the
> mentioned commit fails to handle the case when the user is holding some
> key before the countdown is shown. E.g. if BOOTDELAY=3D101, the next
> malformed output is being produced:
>
>     Hit any key to stop autoboot: 1 0
>
> That's because the fast path code wasn't modified accordingly, and still
> tries to erase the number using '\b\b\b' format.
>
> Fix both issues by introducing a dedicated routine for printing the
> whole countdown line.
>
> Fixes: 5f70be08b015 ("Fix autoboot countdown printing wrong")
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---

Just for the context: I also tried experimenting with only erasing the
countdown number, to avoid printing the whole line to the serial port
each second (as I/O is usually quite slow). The code is below, for the
reference. Maybe it works faster, I don't know, but the code is more
bulky and it grows the binary by +50 bytes:

            e850-96        : all +50 rodata -38 text +88
               u-boot: add: 1/0, grow: 1/0 bytes: 88/0 (88)
                 function                                   old     new   d=
elta
                 erase_int                                    -      72    =
 +72
                 autoboot_command                           304     320    =
 +16

The patch I submitted reduces the footprint by 45 bytes:
            e850-96        : all -45 rodata -41 text -4
               u-boot: add: 0/0, grow: 0/-1 bytes: 0/-4 (-4)
                 function                                   old     new   d=
elta
                 autoboot_command                           304     300    =
  -4

So all in all I think the patch I submitted is more elegant than the
code below. But FWIW:

8<-------------------------------------------------------------------------=
->8
diff --git a/common/autoboot.c b/common/autoboot.c
index e39f4a32f957..dcdc1ca557b0 100644
--- a/common/autoboot.c
+++ b/common/autoboot.c
@@ -5,6 +5,7 @@
  */

 #include <config.h>
+#include <ansi.h>
 #include <autoboot.h>
 #include <bootretry.h>
 #include <cli.h>
@@ -376,19 +377,33 @@ static int abortboot_key_sequence(int bootdelay)
     return abort;
 }

+static void erase_int(int val)
+{
+    while (val > 9) {
+        val /=3D 10;
+        putc('\b');
+    }
+
+    putc('\b');
+    puts(ANSI_CLEAR_LINE_TO_END);
+}
+
 static int abortboot_single_key(int bootdelay)
 {
     int abort =3D 0;
     unsigned long ts;
+    int cur_bootdelay; /* currently printed boot delay */

-    printf("Hit any key to stop autoboot: %2d ", bootdelay);
+    printf("Hit any key to stop autoboot: %d", bootdelay);
+    cur_bootdelay =3D bootdelay;

     /*
      * Check if key already pressed
      */
     if (tstc()) {    /* we got a key press    */
         getchar();    /* consume input    */
-        puts("\b\b\b 0");
+        erase_int(cur_bootdelay);
+        putc('0');
         abort =3D 1;    /* don't auto boot    */
     }

@@ -410,7 +425,9 @@ static int abortboot_single_key(int bootdelay)
             udelay(10000);
         } while (!abort && get_timer(ts) < 1000);

-        printf("\rHit any key to stop autoboot: %1d\033[K", bootdelay);
+        erase_int(cur_bootdelay);
+        printf("%d", bootdelay);
+        cur_bootdelay =3D bootdelay;
     }

     putc('\n');
--=20
2.39.5

8<-------------------------------------------------------------------------=
->8
