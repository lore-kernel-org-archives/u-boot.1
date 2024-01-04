Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CE3C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:06:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28EE08797B;
	Thu,  4 Jan 2024 16:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CNUople3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C77F8796B; Thu,  4 Jan 2024 16:06:47 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 180A68797D
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40d4a7f0c4dso5820875e9.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704380802; x=1704985602;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hzQA0qfQqV4TQeCv8+sXMcpOdwwpO+ssUqed51yCVfM=;
 b=CNUople33hm74ZcyX+QdMdzOzJDWDSXUK+4aIiUdHjspBn+LW5z7dSTPP5yp/sEs+b
 2TqPwEJzeTRYVsS9UUJY/mlEWjyXbIgsOMZTTYh/eNVVqRL+29/yEho/J9F8vDeOtVbx
 wJ8lPemv/otV7L3cDx2AGGetADG07/ZGN4cnLSkdbeoiWpfAFFIqUFkGzPpx11Q3LbKY
 ZnM9ILjGJH/DOEQ7DuRPlvD0xaISMlQ6XPBtp8oXqq+pYqwgODMB5wru5EUol4LA9xTS
 tI9LVMtT52Svuy1JwrjpzvpGN2/llhHUalCzYPjP6Vx4yeQh9XjSqbRNpoqBvZrX17F1
 BMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704380802; x=1704985602;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hzQA0qfQqV4TQeCv8+sXMcpOdwwpO+ssUqed51yCVfM=;
 b=czGKnFPzx91TvxwFc32caNFFOmoW5d6jmmeD1KlYnUjokN0RQir9dQnNsya2unvkUk
 bzVwoT52KmXLud0TY5fCWr3D9XpEXfdRw9hA+VvdexxHH+kp982RchX7+sji2XS0MSFq
 QBKM57YHe/AT/hDDBdXfz4vQwxiWLu6JSmHP9GRJBr5ScnQ6sfLMRTAukv2PTv/MUPJ4
 4iRaCp9HPtNznlQXcCag5nOVhBcsbOsHmy+rP+LrfcZV9KbvWXIjO+k7ZKkKwj/dtKBv
 7xApTmhSCYfvZ9Y0SL4jJ/NOdF/V3/QUxBK557FWanqGJZ/JZHGoj3yd3Wv1K7hwlIvv
 kRQw==
X-Gm-Message-State: AOJu0Yy8eCe3fJYzFj24QuQH9XF87ZIehkx9+C7mCO7GVwj36WXj9TDS
 uyQfmZRnWGzE/drk5NsGl/MsaH8yjVavGA==
X-Google-Smtp-Source: AGHT+IEdjO6Z+2hx6C9+Yx6/TByuhpdpUVN0hIb9QKV1DTfFrIoC5IhfxPq3xBJb2kmfLPv6hf+fIA==
X-Received: by 2002:a05:600c:350b:b0:40d:8987:eb06 with SMTP id
 h11-20020a05600c350b00b0040d8987eb06mr458236wmq.43.1704380802406; 
 Thu, 04 Jan 2024 07:06:42 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 m1-20020a05600c4f4100b0040d5b849f38sm6102166wmq.0.2024.01.04.07.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:06:42 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>, Ion
 Agorria <ion@agorria.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Harald Seiler <hws@denx.de>, Sean Anderson <sean.anderson@seco.com>, Heiko
 Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v6 4/6] common: console: record console from the beginning
In-Reply-To: <CAFLszTjA0_Cteg-L7VGQHysHBq5QH5YVgiVs3h2ODF532VpqoA@mail.gmail.com>
References: <20231228180154.50473-1-clamor95@gmail.com>
 <20231228180154.50473-5-clamor95@gmail.com>
 <CAFLszThd95iSPMOBr_21_Zckg74BtgA23EVpfXQKqnArFc-UDQ@mail.gmail.com>
 <CAPVz0n3OwhrW41tV9x32UXyL6yZdLr8CU9S7XuTneDiwUQY7AQ@mail.gmail.com>
 <8734vg5afv.fsf@baylibre.com>
 <CAFLszTjmvpbxGguK+FuXZLO=kpYR4pVr4E27BGn1u0B-6uB2eQ@mail.gmail.com>
 <87le964mii.fsf@baylibre.com>
 <CAFLszTjA0_Cteg-L7VGQHysHBq5QH5YVgiVs3h2ODF532VpqoA@mail.gmail.com>
Date: Thu, 04 Jan 2024 16:06:41 +0100
Message-ID: <87ttntm932.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Simon,

On mer., janv. 03, 2024 at 18:38, Simon Glass <sjg@chromium.org> wrote:

> Hi Mattijs,
>
> On Wed, Jan 3, 2024 at 5:41=E2=80=AFAM Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>>
>> Hi Simon,
>>
>> On Tue, Jan 02, 2024 at 07:06, Simon Glass <sjg@chromium.org> wrote:
>>
>> > Hi Mattijs,
>> >
>> > On Tue, Jan 2, 2024 at 2:52=E2=80=AFAM Mattijs Korpershoek
>> > <mkorpershoek@baylibre.com> wrote:
>> >>
>> >> Hi Simon, Svyatoslav,
>> >>
>> >> On Thu, Dec 28, 2023 at 21:52, Svyatoslav Ryhel <clamor95@gmail.com> =
wrote:
>> >>
>> >> > =D1=87=D1=82, 28 =D0=B3=D1=80=D1=83=D0=B4. 2023=E2=80=AF=D1=80. =D0=
=BE 21:48 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
>> >> >>
>> >> >> On Thu, Dec 28, 2023 at 6:02=E2=80=AFPM Svyatoslav Ryhel <clamor95=
@gmail.com> wrote:
>> >> >> >
>> >> >> > From: Ion Agorria <ion@agorria.com>
>> >> >> >
>> >> >> > Set flag to enable console record on console_record_init
>> >> >> > and not only on console_record_reset_enable. This fixes
>> >> >> > missing start of U-Boot log for fastboot oem console
>> >> >> > command.
>> >> >> >
>> >> >> > Signed-off-by: Ion Agorria <ion@agorria.com>
>> >> >> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>> >> >> > Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> >> >> > ---
>> >> >> >  common/console.c | 3 +++
>> >> >> >  1 file changed, 3 insertions(+)
>> >> >>
>> >> >> Reviewed-by: Simon Glass <sjg@chromium.org>
>> >> >>
>> >> >> OK, I can see the use of this...but I wonder if we can now get rid=
 of
>> >> >> the same line of code from console_record_reset_enable() ?
>> >> >>
>> >> >
>> >> > Interesting question but let's leave it to a dedicated patch :)
>> >>
>> >> I've looked a little more into to this, and I'm not so sure we can get
>> >> rid of the gd->flags |=3D GD_FLG_RECORD; in console_record_reset_enab=
le().
>> >>
>> >> Removing the flag seems to break quite some tests in
>> >> test/py/tests/test_ut.py.
>> >>
>> >> The breakage can be explained that various unit tests clear the
>> >> GD_FLG_RECORD with:
>> >>
>> >>         gd->flags &=3D ~GD_FLG_RECORD;
>> >>
>> >> Therefore, I would suggest we keep the flag in
>> >> console_record_reset_enable().
>> >
>> > From my look all of those are not needed in tests, i.e. are bugs. If
>> > you are able to do a patch to remove those lines, it would avoid the
>> > confusion.
>>
>> With gd->flags |=3D GD_FLG_RECORD removed from
>> console_record_reset_enable(),
>>
>> When I run:
>> $ ./test/py/test.py --bd sandbox --build -k ut
>>
>> It produces this list of the the tests that fail:
>> https://paste.debian.net/1302906/
>>
>> I can also reproduce individually with a bootflow test, for example:
>> $ ./test/py/test.py --bd sandbox --build -k ut_bootstd_bootflow_cmd_boot
>>
>> Produces:
>> https://paste.debian.net/1302907/
>>
>> I did not investigate more on detail but it seems not trivial to me.
>
> Did you add UT_TESTF_CONSOLE_REC to each test as well?

Here are the steps I did:
1. Take base commit dffa6d0210f5 ("Merge tag 'dm-next-1124' of https://sour=
ce.denx.de/u-boot/custodians/u-boot-dm into next")
2. Apply series: b4 shazam 20231228180154.50473-1-clamor95@gmail.com
3. Run bootflow_cmd_boot test, which passes.
4. Apply the following diff:

diff --git a/common/console.c b/common/console.c
index cad65891fc9f..1bff80029266 100644
--- a/common/console.c
+++ b/common/console.c
@@ -837,7 +837,6 @@ void console_record_reset(void)
 int console_record_reset_enable(void)
 {
        console_record_reset();
-       gd->flags |=3D GD_FLG_RECORD;
=20
        return 0;
 }
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 104f49deef2a..6a98f42f2707 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -482,7 +482,6 @@ BOOTSTD_TEST(bootflow_scan_glob_bootmeth, UT_TESTF_DM |=
 UT_TESTF_SCAN_FDT);
 /* Check 'bootflow boot' to boot a selected bootflow */
 static int bootflow_cmd_boot(struct unit_test_state *uts)
 {
-       console_record_reset_enable();
        ut_assertok(run_command("bootdev select 1", 0));
        ut_assert_console_end();
        ut_assertok(run_command("bootflow scan", 0));
@@ -506,7 +505,7 @@ static int bootflow_cmd_boot(struct unit_test_state *ut=
s)
=20
        return 0;
 }
-BOOTSTD_TEST(bootflow_cmd_boot, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_cmd_boot, UT_TESTF_DM | UT_TESTF_SCAN_FDT | UT_TESTF=
_CONSOLE_REC);
=20
 /**
  * prep_mmc_bootdev() - Set up an mmc bootdev so we can access other distr=
os

5. Run bootflow_cmd_boot test, which now fails.

>
>
>>
>> I can continue the investigation in the coming weeks but I would like
>> to apply this series this week.
>>
>> >
>> > Also, by setting UT_TESTF_CONSOLE_REC for a test, console recording is
>> > set up automatically, so the console_record_reset_enable() is not
>> > needed at the start of the test.
>>
>> I was not aware of that, thank you.
>>
>> >
>> > Regards,
>> > Simon
