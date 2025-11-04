Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56CBCCFA06
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 13:52:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E340835B3;
	Tue,  4 Nov 2025 14:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QNCRwk0t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E796836D1; Tue,  4 Nov 2025 08:16:42 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E633E8144A
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 08:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sudarsansamy2002@gmail.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3d1cf5c2805so6502951fac.2
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 23:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762240598; x=1762845398; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZPxdKIFr364Q/0b3uk7vGt8i5Q7FwxazwKHVMOpo4a4=;
 b=QNCRwk0txq4HDalEhrn59y4PFiC6pwKhnEuueO+rrFZeh2csYcEcAXqYm52lWWml6U
 OahJqI2xacsXIoLgYQl0bjAUxav2ufX1U6fucPTs503XQb7/QsuKYnNlEUK61cgbM0Ah
 mlMhEH6J88Tj3lbbHeK01FvbIurhjYfkq46myhdJgBu4nuQu9FgfAkcpL7nwlCX5ezYE
 Ftto8hnbk1adi0qdEoAABR6lCaUctZcW7xAh1Exbw5CHw9XQNuOxdDRjIu4b6q2Az2nR
 6RHCd1MkWwazdo0j9DkZYc2C4LrxplIj2tjxiqAKBiAG5sL0eEvYR0aawkpFNKhMuCc3
 Jtdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762240598; x=1762845398;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZPxdKIFr364Q/0b3uk7vGt8i5Q7FwxazwKHVMOpo4a4=;
 b=hpGuZin9wJem9AaPkWZrv+m11LtBacrPmeU/lKW6BbbQgsc/LWjZY9ZG9/hCRXOC7f
 MEZKp+BjxecRiRnoNlWPMUx/iX008SynZt68US7CQ9Bu0Yw/TLzOYpsuSfpX6oM16F2f
 b0e1HqKztm2TMduXf6oPBW0qOTiWHzGSIF/AY6bi/1aEmjlN+E8V/EzE72pU5/iZtPrg
 uemRRkxoRFbNcBmmWxNiP4ms6xQRTraNvnnjK+83bDH0sMPh1tvKShgobB5UHyN+RvVo
 XpHjB6jBLF6bY57nEXL/m2jHjizAzTRoaYy6LkIZfqD3kh717T8PjaygcPSKZgla3v6r
 K9rw==
X-Gm-Message-State: AOJu0YyHH+h6aRgRT9FFpyevirg1AHyU7Ii5s4O/qfx6QpmOLWwRR81s
 cWTUxk83C8Q2FjHpn9CdABeezIG8JvAgOgl6V93ywG3Pj+NtDp+mkTwWnO2zTWKYKuEt5KkfkQZ
 MrCxdYIyX092H1K8MYn/cEdgnyI8hI65soQmu
X-Gm-Gg: ASbGncsRy/UU0mIYIZQKFNCPOFERUBi3WB03GqhmiowP5gTZgoafkKVJevpTRZ1E0Wt
 e71i1MVWNBeuxo00tIjB3f0kxe90s0By1xDASgosF6a+tP9iZbC/0CbnW1k2LVfNBjwLr8prq6g
 29YvwRQHz12i33sfwR2g8IxsZI/0BZs4/NAAGqM+63IGoGdbn43tzdDGmXGySi698DqS9iOqaM9
 qmxugjstaxzbwLiVa36TJumr5IjHiCLrAfuQuJubBirKkHWcbItpauQf+Tiglr9ziDXDo9K
X-Google-Smtp-Source: AGHT+IHpYG+vZLxtWfRfEc7gQuy+4b/pMJvg8flvKnGow+ibojzhuscZbyS82qI5lu8G0JNSeDRPhFysMTdCqunXNBk=
X-Received: by 2002:a05:6871:8417:b0:3d3:363d:5a67 with SMTP id
 586e51a60fabf-3dace28e3f4mr7044559fac.50.1762240598398; Mon, 03 Nov 2025
 23:16:38 -0800 (PST)
MIME-Version: 1.0
From: sudarsan n <sudarsansamy2002@gmail.com>
Date: Tue, 4 Nov 2025 12:46:27 +0530
X-Gm-Features: AWmQ_bkfJqkFpEVepbdrMPV0B4KxwhwM3I9eITuApPx_TD2mw5an75nS7F83DRM
Message-ID: <CAFxh7VSzz3gkxiCC+h6W0Drx3xkJ3UA87aY9UqkkWOfnK5Pdqg@mail.gmail.com>
Subject: How to regenerate lpddr4_timing.c when porting from U-Boot 2023.04 to
 2025.04 (i.MX8MQ)
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Tue, 04 Nov 2025 14:51:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi all,

I=E2=80=99m currently working on *migrating U-Boot from version 2023.04 to =
2025.04*
for the *NXP i.MX8MQ* platform, and I=E2=80=99ve run into issues related to=
 the
*lpddr4_timing.c* file.

In the older U-Boot (2023.04) BSP, this file was available under the board
directory (e.g. board/freescale/imx8mq_evk/lpddr4_timing.c) and contained
all DDR initialization parameters and timing configurations.

However, in the *2025.04* version, I see:

   -

   The structure of the DDR init code has changed.
   -

   Several *APIs are deprecated* and *macros have been updated/renamed*.
   -

   The newer timing files contain more *hexadecimal configuration data
   blocks*, and references to new DDR PHY macros and structs.

I would like to confirm:

   1.

   *What is the current recommended method to generate lpddr4_timing.c* for
   i.MX8MQ in the newer U-Boot (2025.04)?
   2.

   Should I use *NXP=E2=80=99s DDR Tool (e.g. DDR Tool from the BSP / i.MX8=
 DDR
   calibration package)* to regenerate it?
   3.

   Is there any *migration guide or documentation* for converting the old
   lpddr4_timing.c format to the new structure (used in U-Boot 2025.x)?
   4.

   Are there any examples in the latest *imx-mkimage* or *NXP U-Boot branch=
*
   that show the updated timing file format for i.MX8MQ?

Any reference to the proper tool version, documentation, or example source
would be very helpful.

Thanks in advance,

*Sudarsan*
