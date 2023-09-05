Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E04EC83F2C
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 05:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6CAD8609B;
	Tue,  5 Sep 2023 07:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="uZ0qYLXg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2464F86555; Tue,  5 Sep 2023 07:02:31 +0200 (CEST)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4DDC81FA8
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 07:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20230905050221epoutp0275c14f3ab0a94c8447d510c7f104dd53~B6Bvr_cax2693526935epoutp02A
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 05:02:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20230905050221epoutp0275c14f3ab0a94c8447d510c7f104dd53~B6Bvr_cax2693526935epoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693890141;
 bh=LmSVt8lxrWF6acALVOMnt5RNUqYhoGG4dUzjMRChLUE=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=uZ0qYLXgD2mMZ60fCVqw57SrM2eBfo6i9YlPSiPgY9AhXY/aIv3D0GmXNF6+8kXFQ
 of6jhTX+dY0bl7/Zv6FQtstqGOvLYEP06lMpouA+L2HDXAQ8VDapzlMF/KPff9eFi5
 hE0Hl7kugMVDZ7hokZ+KSna3lFU0Z1fFGfh5oWNs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20230905050221epcas2p1a24d61ea3c2032b9bc2432f30445692f~B6BvTq3lU0340903409epcas2p1P;
 Tue,  5 Sep 2023 05:02:21 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.68]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4RftfN3wrMz4x9Pp; Tue,  5 Sep
 2023 05:02:20 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 B6.AD.08583.C56B6F46; Tue,  5 Sep 2023 14:02:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20230905050220epcas2p34939db5d4b4d5088bd3f09b239a37704~B6BuYUp4g2593425934epcas2p3E;
 Tue,  5 Sep 2023 05:02:20 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230905050220epsmtrp265154dd564bdb13dd4dbdefb11e9591e~B6BuXxCSr2879128791epsmtrp2Z;
 Tue,  5 Sep 2023 05:02:20 +0000 (GMT)
X-AuditID: b6c32a43-96bfd70000002187-ff-64f6b65c2057
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 81.F4.18916.B56B6F46; Tue,  5 Sep 2023 14:02:19 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20230905050219epsmtip1062c19558c01842b45ecf670a41adff8~B6BuN9s8O0202802028epsmtip1K;
 Tue,  5 Sep 2023 05:02:19 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Simon Glass'" <sjg@chromium.org>
Cc: "'Rick Chen'" <rick@andestech.com>, "'Leo'" <ycliang@andestech.com>,
 <u-boot@lists.denx.de>
In-Reply-To: <CAPnjgZ2eKzzcyjBG_EKbCLMM_9x4h4O4ABPMgX6vY_ScD=tZUA@mail.gmail.com>
Subject: RE: [PATCH v2 3/3] timer: riscv_aclint_timer: add timer_get_boot_us
 for BOOTSTAGE
Date: Tue, 5 Sep 2023 14:02:19 +0900
Message-ID: <003001d9dfb6$260f2930$722d7b90$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKO/hFpQCIJv5N4xDW6Es6peGHY4AJDo85+AXmVEGsB//jQZa5zhcYQ
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmqW7Mtm8pBlfOyli8fXGW0eLblm2M
 Fm/3drJbPD70msmBxWPP6VnMHrMbLrJ4nL2zgzGAOSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzje
 Od7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdonZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
 Vim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO2PnBZmClYIVc1ccZmxgPMLXxcjBISFg
 IvFrE28XIxeHkMAORomzfw8wQzifGCU2n1/J1sXICeFMXMQOYoM0LHs9jQ2iaCejxMr1X1kg
 nBeMEufOnmEGqWIT0Jd42bGNFcQWEVCTeLvgBFg3s0CixLStX8GmcgoESny88B/MFhaIkfgw
 CyLOIqAicWDmTxYQm1fAUqJv8y0mCFtQ4uTMJywQc7Qlli18zQxxkYLEz6fLoHa5SdxecR6q
 Rlzi5dEj7CDHSQh8ZZd4u20q1AsuEk+WLWCEsIUlXh3fAhWXkvj8bi8bJFzKJXYsS4LobWGU
 aG7bA7XMXuLHzSmsIDXMApoS63fpQ5QrSxy5BbWWT6Lj8F92iDCvREebEESjusSB7dNZIGxZ
 ie45n1knMCrNQvLYLCSPzULywCyEXQsYWVYxiqUWFOempyYbFRjCYzo5P3cTIzgZajnvYLwy
 /5/eIUYmDsZDjBIczEoivO/kv6UI8aYkVlalFuXHF5XmpBYfYjQFBvVEZinR5HxgOs4riTc0
 sTQwMTMzNDcyNTBXEue91zo3RUggPbEkNTs1tSC1CKaPiYNTqoEpuzVZ4iBXRhh3YdHu1Qs/
 XTh9PdZEuOPB+ZCgz94fQvw13vHaLeazk3vrwfnQ7H7TIbdlPLcX7pqXcdSoZO3Ln5MTuUxV
 Y2ckCp4Xf7VwzYOeb53Rzd69lUrS3w66Jy+LnWZ8+8KOeg3hl4aX3+dXp0pcv/hrVkPGgfds
 1Z2Kabkyx+Ydie1Z03NE8Wf87L4ex9/6U6wDb7duqgt1ZWth/D5Ps3NtQ9W8uVxsO9fuVpn7
 1PhUcvAlJ9myz7nnEk/ezLhg8Jd5TmfD8yfsCkduXYya8H977Fw1idfr9jheeVS4odTJwGFK
 7L1jdWe6HuwoS2+4/3Hm56rtUQtjO34fyNx1d1PWG4Zzb1TdrrwJV2Ipzkg01GIuKk4EAHzT
 jbYPBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSnG7Mtm8pBv/NLN6+OMto8W3LNkaL
 t3s72S0eH3rN5MDisef0LGaP2Q0XWTzO3tnBGMAcxWWTkpqTWZZapG+XwJVxdHInc8ELgYo9
 726yNDA28nUxcnJICJhILHs9ja2LkYtDSGA7o0T34p/sEAlZiWfvdkDZwhL3W46wQhQ9Y5T4
 uWQyK0iCTUBf4mXHNjBbREBN4u2CE2ANzALJEmvOLGGHaOhhknh6/T8bSIJTIFDi4wUIW1gg
 SmL7mqPMIDaLgIrEgZk/WUBsXgFLib7Nt5ggbEGJkzOfsEAM1ZbofdjKCGMvW/iaGeI6BYmf
 T5dBHeEmcXvFeah6cYmXR4/AfdO9s4cN5pu7D16yT2AUnYVkxSwkK2YhWTELyagFjCyrGEVT
 C4pz03OTCwz1ihNzi0vz0vWS83M3MYLjSCtoB+Oy9X/1DjEycTAeYpTgYFYS4X0n/y1FiDcl
 sbIqtSg/vqg0J7X4EKM0B4uSOK9yTmeKkEB6YklqdmpqQWoRTJaJg1OqgWlGvUjqAnWzo64+
 XJoLX9cqB21nPttRPDVbnKd24rlrYZvW1RtofOa57PFra+BCfTv9TfsdTh3/7LZ7m1PDtbUv
 PnfOKfwxI3DH0l1V71+FZW34PtP8TZJKnbZP+jq/M0cq5MyFzNfm1nbdfFq45b67/e+4h+ra
 n/MPK3iEpMn7Vq5d+7Zizb8DIs8OcH6ySYiTKk6ZVpyplTchVpTvkJ3VgiA1xcx6y08La89b
 tbwVVL9X8vgwn8Kj9dsZJiSG22e+uCr1KuNSyXOFs28uTjq5vPlEQsjDiNQYK2meGar903o+
 njvA6F/ktszW8OzXR0LPv2xYOblyeWpZ7O1dvVfvzlhusNlRVdxl+y+uo6+UWIozEg21mIuK
 EwHzpXAiEgMAAA==
X-CMS-MailID: 20230905050220epcas2p34939db5d4b4d5088bd3f09b239a37704
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230828094953epcas2p3fc191dd7a0d387cfd987240b972c79b5
References: <CGME20230828094953epcas2p3fc191dd7a0d387cfd987240b972c79b5@epcas2p3.samsung.com>
 <20230828094938.2061606-1-chanho61.park@samsung.com>
 <20230828094938.2061606-4-chanho61.park@samsung.com>
 <CAPnjgZ2eKzzcyjBG_EKbCLMM_9x4h4O4ABPMgX6vY_ScD=tZUA@mail.gmail.com>
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
> Sent: Tuesday, September 5, 2023 1:49 AM
> To: Chanho Park <chanho61.park=40samsung.com>
> Cc: Rick Chen <rick=40andestech.com>; Leo <ycliang=40andestech.com>; u-
> boot=40lists.denx.de
> Subject: Re: =5BPATCH v2 3/3=5D timer: riscv_aclint_timer: add
> timer_get_boot_us for BOOTSTAGE
>=20
> Hi Chanho,
>=20
> On Mon, 28 Aug 2023 at 03:50, Chanho Park <chanho61.park=40samsung.com>
> wrote:
> >
> > timer_get_boot_us function is required to record the boot stages as
> > us-based timestamp.
> >
> > Signed-off-by: Chanho Park <chanho61.park=40samsung.com>
> > ---
> >  drivers/timer/riscv_aclint_timer.c =7C 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/drivers/timer/riscv_aclint_timer.c
> b/drivers/timer/riscv_aclint_timer.c
> > index e29d527c8d77..8b67745bb4a2 100644
> > --- a/drivers/timer/riscv_aclint_timer.c
> > +++ b/drivers/timer/riscv_aclint_timer.c
> > =40=40 -6,6 +6,7 =40=40
> >
> >  =23include <common.h>
> >  =23include <clk.h>
> > +=23include <div64.h>
> >  =23include <dm.h>
> >  =23include <timer.h>
> >  =23include <asm/io.h>
> > =40=40 -44,6 +45,27 =40=40 u64 notrace timer_early_get_count(void)
> >  =7D
> >  =23endif
> >
> > +=23if CONFIG_IS_ENABLED(RISCV_MMODE) && CONFIG_IS_ENABLED(BOOTSTAGE)
>=20
> Just a nit...you should not need this =23if, since if the function is
> not used it will be stripped from the image by the linker.

Thank you for the suggestion.
Without these guards, compile error can be occurred due to multiple timer_g=
et_boot_us definitions.
For risc-v, there are two timers for S-mode and M-mode, respectively.
So, I put them to avoid below build errors.

riscv64-unknown-linux-gnu-ld.bfd: drivers/timer/riscv_aclint_timer.o: in fu=
nction =60timer_get_boot_us':

/data/risc-v/qemu/u-boot/drivers/timer/riscv_aclint_timer.c:49: multiple de=
finition of =60timer_get_boot_us'; drivers/timer/riscv_timer.o:/data/risc-v=
/qemu/u-boot/drivers/timer/riscv_timer.c:55: first defined here

make=5B1=5D: *** =5Bscripts/Makefile.spl:527: spl/u-boot-spl=5D Error 1

Best Regards,
Chanho Park

