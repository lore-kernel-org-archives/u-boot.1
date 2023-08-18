Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255C9C001DE
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 04:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7275186C7A;
	Fri, 18 Aug 2023 06:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="uiN0OUP2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E1AC86C78; Fri, 18 Aug 2023 06:40:47 +0200 (CEST)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6232B86C8C
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 06:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20230818044039epoutp029043794dbddb804c4e6ae9fc3a2bbdf9~8YHqEHqOD0336903369epoutp02Y
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 04:40:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20230818044039epoutp029043794dbddb804c4e6ae9fc3a2bbdf9~8YHqEHqOD0336903369epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1692333639;
 bh=T6Ya3nlYlxZN20k+wfZVINoB2fa3o9746u2EtOAqBrM=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=uiN0OUP2wlmGHkvKKAYEaeeFMFVfppuC8/EwoMN5Rj9rEE2jTnwQAjPVQAi1hlShk
 L2ci2/GCmJIRCW5pZaWAhYJYfTWZDAoGWPMU5QNZxtRHbGhWBzGlTYprwRWEdbHLiS
 qej0jdCJftBW1yvrpAb+CDLwA0VaQAim8j90zebU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20230818044036epcas2p4a93d718bf7bc58f605f432e0e5013cce~8YHnIgGRi1330213302epcas2p4N;
 Fri, 18 Aug 2023 04:40:36 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.100]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4RRq1b4FlDz4x9QC; Fri, 18 Aug
 2023 04:40:35 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 62.58.50232.346FED46; Fri, 18 Aug 2023 13:40:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20230818044034epcas2p4abf8235871c2ea9ce1c1bb6a474023d9~8YHmBCO6q1328313283epcas2p4C;
 Fri, 18 Aug 2023 04:40:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230818044034epsmtrp13b964f23403bbcb02a257c34c7834e92~8YHmAQmQ00388203882epsmtrp1M;
 Fri, 18 Aug 2023 04:40:34 +0000 (GMT)
X-AuditID: b6c32a4d-0e7ff7000006c438-3f-64def643b867
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 2D.6A.34491.246FED46; Fri, 18 Aug 2023 13:40:34 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20230818044034epsmtip1a0bd78332a3227c66c16f89756764f24~8YHlyqcPV1522815228epsmtip1U;
 Fri, 18 Aug 2023 04:40:34 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Simon Glass'" <sjg@chromium.org>
Cc: <u-boot@lists.denx.de>, "'Bin Meng'" <bmeng.cn@gmail.com>
In-Reply-To: <CAPnjgZ2PbHVY_WLVq7XCd-HYKKwoh8R3LGXfOo7S6Sbvj0+ETA@mail.gmail.com>
Subject: RE: [PATCH] dm: core: allow DM_POST_INIT_F notification for
 TIMER_EARLY
Date: Fri, 18 Aug 2023 13:40:34 +0900
Message-ID: <006701d9d18e$20a81d70$61f85850$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL4PwMj5AfpDM6brAedznDH33y+oAHWB/vwAcF8amqtleEB0A==
Content-Language: ko
x-msg-type: PERSONAL
x-drm-type: PERSONAL
x-delete-securityphrase: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmqa7zt3spBnduCVhM7Ym3+LZlG6PF
 272d7A7MHrMbLrJ47Jx1l93j7J0djAHMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
 hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
 5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGY/fT2MvWCFe0da+lqmBcblQFyMnh4SAicSSZT9Y
 uhi5OIQE9jBKXFuwgBnC+cQocefGT3YI5xujxPwnO9hhWtoufWSESOxllDj4aikThPOCUWLN
 hGZWkCo2AX2Jlx3bwGwRATWJtwtOgHUzC9hKbNnRDWZzCgRKvJ77lwnEFhYIknh/7ScbiM0i
 oCqxqQvE5uDgFbCU+L1FACTMKyAocXLmExaIMdoSyxa+ZoY4SEHi59NlrCDlIgJOEt8fmkOU
 iEjM7myDKhGR6N5ymwmkBMS+sycFIiwlMfv1S6i3FnJInPppBGG7SExq2cEIYQtLvDq+hR2m
 /mV/GzvEmHKJHcuSQB6XEGhhlGhu2wO1yl7ix80pYNcwC2hKrN+lD3ENn0TH4b9QrbwSHW1C
 ExhVZiF5axaSt2YhuX8WwqAFjCyrGKVSC4pz01OTjQoMdfNSy+GxnZyfu4kRnAi1fHcwvl7/
 V+8QIxMH4yFGCQ5mJRFeC6Z7KUK8KYmVValF+fFFpTmpxYcYTYFhPZFZSjQ5H5iK80riDU0s
 DUzMzAzNjUwNzJXEee+1zk0REkhPLEnNTk0tSC2C6WPi4JRqYJr/Wnldx06n2O2SsVPcL9Uz
 vGZ1ebH/+UY2E96btQm3jG63nl9+klHitHRmcdK5w+Un7Jb6nRfTe/dyVv/kNYlRancL5m+c
 cb677F7I11n3Foh5ee36kaL9mnPajMV/7PetuBxfb8MxzXriZVn1EveN5jvfWUr//LupNT/a
 O69pQqvZywChRMFXKax7n2s2szhe0Zh0zCnxyqT3mSXVKcZNnnOmp7+Zp1deofb/SRtn64dt
 rxZe/b0wUfvj29ms1TeZ9ngZXT27c/MhL80i+YnTFh46ZhrjtUP/rw7/ZKWKjT+5DqVMf9I6
 2/m4bX3jgwMVWdJuApPLlCQvbpqWG5c0O0Xp89/+JGGv7zsPpqQqsRRnJBpqMRcVJwIAnNbY
 Nw0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSnK7Tt3spBlcfGlpM7Ym3+LZlG6PF
 272d7A7MHrMbLrJ47Jx1l93j7J0djAHMUVw2Kak5mWWpRfp2CVwZbW2bGAvuiVVMfCnawHhT
 sIuRk0NCwESi7dJHRhBbSGA3o8TLtwoQcVmJZ+92sEPYwhL3W46wdjFyAdU8Y5Q4c2sTG0iC
 TUBf4mXHNlYQW0RATeLtghNgDcwC9hIPX32HarjOKPHjwgqwBKdAoMTruX+ZQGxhgQCJFb+n
 gtksAqoSm7p+Ag3l4OAVsJT4vUUAJMwrIChxcuYTFoiZ2hJPbz6Fs5ctfM0McZyCxM+ny1hB
 WkUEnCS+PzSHKBGRmN3Zxgzzy5+jc9lgfrn74CXUXyIS3VtuM4G0gth39qRAhMUkZk67DNUq
 JTH79Uv2CYySs5AcNAvJQbOQHDQLyeYFjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNz
 NzGCY1NLcwfj9lUf9A4xMnEwHmKU4GBWEuG1YLqXIsSbklhZlVqUH19UmpNafIhRmoNFSZxX
 /EVvipBAemJJanZqakFqEUyWiYNTqoFpBXvmZslJZ4uVNJZ0O9jMO8zOfSRE+i3Lznd39y2J
 io89E8bjwXlKac+7VrbYiL6mU9MU1smUC0jf2nQyXPuK4CG/CzdMy/Qc3t06brU7VcsiWn+/
 lYbWs/ad8QFu6zVXbF+86P632WLTtpQ+U1MO3rhD7XcgU9FW1mmJ/+/bGIen5v5du/bkVP7e
 X2+S/j4WslX7M2VeBc+ENxf6d3/1+5zsc0HdKLJj1eyJ2zlrzv+xMy+eGDOnr3XvnjVXl5Sl
 /zxgbNxoWsKlwt65ZQr/kieVfY/3fY1dvXrFz26lMi5P6XN+939GCAp0zb3hOHmSX6xf6hnF
 8v2GUgoRjaFn90ZPOp10M+p9o/iKP/oHlViKMxINtZiLihMBYgtB5DwDAAA=
X-CMS-MailID: 20230818044034epcas2p4abf8235871c2ea9ce1c1bb6a474023d9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230808073547epcas2p48e6a6d53895d244ac34e080f098fd225
References: <CGME20230808073547epcas2p48e6a6d53895d244ac34e080f098fd225@epcas2p4.samsung.com>
 <20230808073537.2889726-1-chanho61.park@samsung.com>
 <CAPnjgZ2PbHVY_WLVq7XCd-HYKKwoh8R3LGXfOo7S6Sbvj0+ETA@mail.gmail.com>
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

> -----Original Message-----
> From: Simon Glass <sjg=40chromium.org>
> Sent: Wednesday, August 9, 2023 2:54 AM
> To: Chanho Park <chanho61.park=40samsung.com>
> Cc: u-boot=40lists.denx.de; Bin Meng <bmeng.cn=40gmail.com>
> Subject: Re: =5BPATCH=5D dm: core: allow DM_POST_INIT_F notification for
> TIMER_EARLY
>=20
> Hi Chanho,
>=20
> On Tue, 8 Aug 2023 at 01:35, Chanho Park <chanho61.park=40samsung.com> wr=
ote:
> >
> > Since the Patch 55171aedda88, VisionFive2 booting has been broken =5B1=
=5D.
> > VisionFive2 board requires to enable CONFIG_TIMER_EARLY but booting
> > went to panic from initr_dm_devices due to lack of a timer device.
> >
> > - Error logs
> > initcall sequence 00000000fffd8d38 failed at call 00000000402185e4
> > (err=3D-19)
> >
> > We can reproduce it on Qemu Sifive HiFive Unleashed emulation=5B2=5D af=
ter
> > enabling CONFIG_TIMER_EARLY manually.
> >
> > =5B1=5D:
> > https://protect2.fireeye.com/v1/url?k=3D38a0f71d-592be204-38a17c52-74fe=
4
> > 85cbfec-8b0f4f7ae7f889ef&q=3D1&e=3D3bf1c52b-7aa0-464a-86d3-ecec3db1395d=
&u=3D
> > https%3A%2F%2Flists.denx.de%2Fpipermail%2Fu-boot%2F2023-June%2F521220.
> > html
> > =5B2=5D:
> > https://www.qemu.org/docs/master/system/riscv/sifive_u.html=23running-u=
-
> > boot
> > Fixes: 55171aedda88 (=22dm: Emit the arch_cpu_init_dm() even only befor=
e
> > relocation=22)
> > Cc: Simon Glass <sjg=40chromium.org>
> > Cc: Bin Meng <bmeng.cn=40gmail.com>
> > Signed-off-by: Chanho Park <chanho61.park=40samsung.com>
> > ---
> >  drivers/core/root.c =7C 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/core/root.c b/drivers/core/root.c index
> > 6775fb0b6575..e939da484b2a 100644
> > --- a/drivers/core/root.c
> > +++ b/drivers/core/root.c
> > =40=40 -436,7 +436,8 =40=40 int dm_init_and_scan(bool pre_reloc_only)
> >                         return ret;
> >                 =7D
> >         =7D
> > -       if (CONFIG_IS_ENABLED(DM_EVENT) && =21(gd->flags & GD_FLG_RELOC=
)) =7B
> > +       if (CONFIG_IS_ENABLED(DM_EVENT) &&
> > +           (=21(gd->flags & GD_FLG_RELOC) =7C=7C
> > + CONFIG_IS_ENABLED(TIMER_EARLY))) =7B
> >                 ret =3D event_notify_null(EVT_DM_POST_INIT_F);
> >                 if (ret)
> >                         return log_msg_ret(=22ev=22, ret);
> > --
> > 2.39.2
> >
>=20
> It looks like you need a new notification. The correct fix would be to ad=
d
> a new EVT_DM_POST_INIT_R event and emit that after relocation, e.g.
>=20
> if (CONFIG_IS_ENABLED(DM_EVENT) =7B
>    ret =3D event_notify_null(gd->flags & GD_FLG_RELOC ?
>          EVT_DM_POST_INIT_R : EVT_DM_POST_INIT_F);
>    if (ret)
>       return log_msg_ret(=22ev=22, ret);
> =7D

Sorry for this late reply.
I feel like I need to move riscv_cpu_probe call from arch_early_init_r and =
make it as the callback of the new event.
I'll send v2 with the changes.

Best Regards,
Chanho Park

