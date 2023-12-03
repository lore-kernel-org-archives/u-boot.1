Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF83C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 08:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F652875B9;
	Sun,  3 Dec 2023 09:15:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="gsAuRBJF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A527875A1; Sun,  3 Dec 2023 09:15:09 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BB3D875B9
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 09:15:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231203081500epoutp04ac3e3b3a172b40c59d9bfc142726cf2d~dREWoIEtN1450714507epoutp04b
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 08:15:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231203081500epoutp04ac3e3b3a172b40c59d9bfc142726cf2d~dREWoIEtN1450714507epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1701591300;
 bh=qDdxETMienDPF0vo8jqeyPzcieqkfQeZ+EeTOzwbjiM=;
 h=From:To:In-Reply-To:Subject:Date:References:From;
 b=gsAuRBJFDadw/i36EYKIa56BaWxYQvb88S2iZFH43YtOV1R5nrjGDTFr+WvQpy5Yn
 S3wDH40L/mPdrZ8dotGvDXlDIs3Ydmqz4YzPhKg78IagT5ov5kVVyB3lIQOUGdpsXB
 iqlki+12b6QgUqeCciBui1gUp3RAdAu/HOmtRA3c=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20231203081459epcas2p1919f9a0c915d67cffe15834ebe048a9a~dREWAC5gq3194931949epcas2p1P;
 Sun,  3 Dec 2023 08:14:59 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.89]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4SjfjZ6zJvz4x9Pp; Sun,  3 Dec
 2023 08:14:58 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 20.62.10006.2093C656; Sun,  3 Dec 2023 17:14:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20231203081458epcas2p2d3f0935f3130f3de69a12045406a34b1~dREUulUse0933209332epcas2p2m;
 Sun,  3 Dec 2023 08:14:58 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231203081458epsmtrp28b19b2623f60056f54e636a7441edb4d~dREUuHuQU0974909749epsmtrp2D;
 Sun,  3 Dec 2023 08:14:58 +0000 (GMT)
X-AuditID: b6c32a45-179ff70000002716-46-656c390281d1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 BD.DB.18939.1093C656; Sun,  3 Dec 2023 17:14:58 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20231203081457epsmtip22711a9103f2b6d6c88a4c80967b753d6~dREUikEUz0974609746epsmtip2C;
 Sun,  3 Dec 2023 08:14:57 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Stefan Roese'" <sr@denx.de>, <u-boot@lists.denx.de>
In-Reply-To: <0b88174d-4342-4d84-af71-ebd63ecd0e59@denx.de>
Subject: RE: [PATCH] watchdog: Correct watchdog timeout print message
Date: Sun, 3 Dec 2023 17:14:57 +0900
Message-ID: <000001da25c0$cdef46d0$69cdd470$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEalYYvoGwCUVf/VAkUHhMfyw0NBwE21d1oAiNH/zkBOZdfA7HxuGyw
Content-Language: en-us
x-msg-type: PERSONAL
x-drm-type: PERSONAL
x-delete-securityphrase: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmuS6TZU6qwYe9ZhYn131gsni7t5Pd
 gclj3qwTLB5n7+xgDGCKyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xN
 tVVy8QnQdcvMAZqvpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwL9ArTswtLs1L
 18tLLbEyNDAwMgUqTMjO2P/wC3vBYfGKizcXsjQwrhbqYuTkkBAwkZiy9BZbFyMXh5DADkaJ
 9yt3s0I4nxgl1l54j+D8ebiDGaZl3okvLBCJnYwSmxpfsUM4LxglJt/8wgRSxSagL/GyYxsr
 iC0iYClxe/MHoG4ODk4Ba4mv641ATGEBV4m+/WDVLAIqEisWvgar4AWqfjDBGSTMKyAocXLm
 ExYQm1lAXmL72zlQJyhI/Hy6DGq4m8TeJwuhasQlXh49wg5RIyLRveU2E8hIEPvOnhSIsJTE
 7NcvwQ6WEGjlkFhyez4LRMJF4saOLqj5whKvjm9hh2n4/G4vG8Sccokdy5IgelsYJZrb9kDV
 20v8uDmFFaSGWUBTYv0ufYhz+CQ6Dv9lh2jllehog4a5usSB7dNZJjAqz0Ly5CwkT85C8sws
 hKELGFlWMYqlFhTnpqcWGxUYwmM6OT93EyM43Wm57mCc/PaD3iFGJg7GQ4wSHMxKIrzzbmWn
 CvGmJFZWpRblxxeV5qQWH2I0BYb6RGYp0eR8YMLNK4k3NLE0MDEzMzQ3MjUwVxLnvdc6N0VI
 ID2xJDU7NbUgtQimj4mDU6qBqefrdJfVJ77HrFzB3fv3yGwlzjUxR99O2l5/JTb99gsnlm+3
 D26NO8DI+sPhc1SvZegVR+dlDTN2zd6kK9io/UFBJSr/bdy7fyFHbCUbrgfY7Ju/x/5C12p5
 C1ehddPtpQ0nXJh9siBVMKlPZ6sbywZWn9nnVV2Pr9t+z997aunXGxK7Vy3bGxkvINnHx9ck
 WOg25Y7k02a/tke1wiZSD6y4nnV1Wm/kV1xxL3wqp+K2uXNvR++8+2r63vCj1eq2U9jjdrlf
 dVr87ouwrkvErSyxy0++KLQ8UNa5qSguvXwdg7n2gVXFv8+b8y5ucW1sfZJWsrahQzLR4sXs
 p0cUuvffeyNZHrzBMXrZwtiQZ0osxRmJhlrMRcWJAPGYLqUABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSvC6TZU6qwfWLTBYn131gsni7t5Pd
 gclj3qwTLB5n7+xgDGCK4rJJSc3JLEst0rdL4MrY//ALe8Fh8YqLNxeyNDCuFupi5OSQEDCR
 mHfiC0sXIxeHkMB2RokPfR0sEAlZiWfvdrBD2MIS91uOsEIUPWOU2Dj9MVgRm4C+xMuObUAJ
 Dg4RAWuJpTPTIGo+ANWcvMsGEucEin9dbwRiCgu4SvTtZwLpZBFQkVix8DUzSJhXwFLiwQRn
 kDCvgKDEyZlPwIYzC2hLPL35FMqWl9j+dg4zxDUKEj+fLmMFsUUE3CT2PlkIVSMu8fLoEXaY
 67t39rDBXH/3wUuouIhE95bbTCBrQew7e1IgwmISM6ddhhovJTH79Uv2CYwSs5BcNAvJRbOQ
 XDQLyeYFjCyrGEVTC4pz03OTCwz1ihNzi0vz0vWS83M3MYIjTStoB+Oy9X/1DjEycTAeYpTg
 YFYS4Z13KztViDclsbIqtSg/vqg0J7X4EKM0B4uSOK9yTmeKkEB6YklqdmpqQWoRTJaJg1Oq
 gYnFRc9uZV1x+IXrHV9Uva7H3w5NaEtpvvM5rnjFxws1G1h0vW/y/FVecyL93Isll/SudW2e
 JWUe9vm1TIbPxkvp8ff4J6pukVzV19yWk/viUeyk8sImEZXgTVufmb3Um7WDd8qn6hqWL3py
 sRt3m/+vV7yyq/numWWfLCYXp/++aH3+2Vaj2gc9YXrfZI0EuHoYDVn3/vvjEq/sarOVSURY
 2GLtp0dvjJt6t1i0pFc7H9jLqRO/af82vfJVZ5Ji35uxbGPK/v+ms/UXr/CujuMCh+ac8Kp4
 sXXnk47rn4/M91nW1n/22zNJ9oI3ORkKG07tFm9n5L92zGX5TYX78yPZhb+l7VIU4f38WMDm
 S7QSS3FGoqEWc1FxIgC6dYxRIwMAAA==
X-CMS-MailID: 20231203081458epcas2p2d3f0935f3130f3de69a12045406a34b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231127010544epcas2p195e888cab27c0cbabd2f4b596404f5d8
References: <CGME20231127010544epcas2p195e888cab27c0cbabd2f4b596404f5d8@epcas2p1.samsung.com>
 <20231127010520.3170033-1-chanho61.park@samsung.com>
 <9f5c0ad9-6e7c-4451-a06c-3d9989358057@denx.de>
 <0b88174d-4342-4d84-af71-ebd63ecd0e59@denx.de>
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

> -----Original Message-----
> From: Stefan Roese <sr@denx.de>
> Sent: Friday, December 1, 2023 7:39 PM
> To: Chanho Park <chanho61.park@samsung.com>; u-boot@lists.denx.de
> Subject: Re: [PATCH] watchdog: Correct watchdog timeout print message
> 
> On 12/1/23 08:37, Stefan Roese wrote:
> > On 11/27/23 02:05, Chanho Park wrote:
> >> The wdt_start function takes timeout_ms as a parameter and starts the
> >> watchdog with this value. However, when you output the message, it
> shows
> >> the default timeout value for the watchdog device.
> >> So this patch fixes that part to output the correct timeout value.
> >>
> >> Before -->
> >> StarFive # wdt start 3000
> >> WDT:   Started watchdog@13070000 without servicing  (60s timeout)
> >>
> >> After -->
> >> StarFive # wdt start 3000
> >> WDT:   Started watchdog@13070000 without servicing  (3s timeout)
> >>
> >> Fixes: c2fd0ca1a822 ("watchdog: Integrate watchdog triggering into the
> >> cyclic framework")
> >> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> >
> > Reviewed-by: Stefan Roese <sr@denx.de>
> >
> > Thanks,
> > Stefan
> >
> >> ---
> >>   drivers/watchdog/wdt-uclass.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/watchdog/wdt-uclass.c
> >> b/drivers/watchdog/wdt-uclass.c
> >> index ed329284decb..65a4bc1f90ed 100644
> >> --- a/drivers/watchdog/wdt-uclass.c
> >> +++ b/drivers/watchdog/wdt-uclass.c
> >> @@ -141,7 +141,7 @@ int wdt_start(struct udevice *dev, u64 timeout_ms,
> >> ulong flags)
> >>           printf("WDT:   Started %s with%s servicing %s (%ds
> timeout)\n",
> >>                  dev->name, IS_ENABLED(CONFIG_WATCHDOG) ? "" : "out",
> >> -               str, priv->timeout);
> >> +               str, (u32)(timeout_ms / 1000));
> 
> Unfortunately this commit break CI build - I tested using Azure CI:
> 
> test.py for QEMU platforms qemu_m68k:
> 
> 
> Successfully installed attrs-23.1.0 jsonschema-4.17.3 pyrsistent-0.20.0
> pyyaml-6.0
> + tools/buildman/buildman -o /tmp/M5208EVBE -w -E -W -e --board
> M5208EVBE -a CONFIG_M68K_QEMU=y -a '~CONFIG_MCFTMR'
> Building current source for 1 boards (1 thread, 2 jobs per thread)
> 
> Starting build...
> 
> 
>      0    0    0 /1       -1      (starting)
> 
>        m68k:  +   M5208EVBE
> +m68k-linux-ld.bfd: drivers/watchdog/wdt-uclass.o: in function `wdt_start':
> +drivers/watchdog/wdt-uclass.c:144:(.text.wdt_start+0xc6): undefined
> reference to `__udivdi3'
> +make[1]: *** [Makefile:1765: u-boot] Error 1
> +make: *** [Makefile:177: sub-make] Error 2
> 
>      0    0    1 /1              M5208EVBE
> Completed: 1 total built, 1 newly), duration 0:00:21, rate 0.05
> ##[error]Bash exited with code '100'.
> ##[warning]RetryHelper encountered task failure, will retry (attempt #:
> 1 out of 2) after 1000 ms
> Generating script.
> 
> Could you please take a look?

Sure. I'll fix it and post the v2 patch.

Best Regards,
Chanho Park

