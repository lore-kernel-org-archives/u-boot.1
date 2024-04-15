Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F77EC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51CBF88195;
	Mon, 15 Apr 2024 08:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="WqLeRvsJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82779881C8; Mon, 15 Apr 2024 08:59:02 +0200 (CEST)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5D30874B1
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240415065857epoutp020c9725d45e9c290c39615aae39aae962~GYeNNODtb3257332573epoutp02Z
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 06:58:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240415065857epoutp020c9725d45e9c290c39615aae39aae962~GYeNNODtb3257332573epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713164337;
 bh=zMuwDz48at7KwVijYxDevApbqIny4SWW8GKLeMzDjEg=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=WqLeRvsJDmDFjBzKLPIJK1n78JniM9uqvGy+8DZrJ4kWhkibz5PE8IEpMoLxgJ3AR
 RAoUpoCu2CasrPMpAiXjNmJAd7AYtWJV6I89h3Z5ydsK4EzcYvvUGIe8Mr9nYVfWIq
 FGGCr2RA9b4e2ZXnW/YH3J/vTMb8C3acbMh3cCbk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20240415065856epcas1p3b77aba2fb78e59f3b6f4ee8a29acb650~GYeM47WGG0164301643epcas1p3T;
 Mon, 15 Apr 2024 06:58:56 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.144]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4VHygz3rPTz4x9QQ; Mon, 15 Apr
 2024 06:58:55 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 41.EB.09663.F20DC166; Mon, 15 Apr 2024 15:58:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20240415065855epcas1p331cb957260728d49f263f735bebc26cb~GYeLYvs2e3178031780epcas1p3W;
 Mon, 15 Apr 2024 06:58:55 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240415065855epsmtrp182dda569372ff6fe4620e035a44b9d29~GYeLYJ8S51169711697epsmtrp1x;
 Mon, 15 Apr 2024 06:58:55 +0000 (GMT)
X-AuditID: b6c32a37-b863ba80000025bf-6a-661cd02f5ed6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D8.28.07541.E20DC166; Mon, 15 Apr 2024 15:58:55 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20240415065854epsmtip2ab700e8c0f050b0772518bbba3a6d712~GYeLJ0ovA2903429034epsmtip25;
 Mon, 15 Apr 2024 06:58:54 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Yang Xiwen'" <forbidden405@outlook.com>, "'Peng Fan'" <peng.fan@nxp.com>
Cc: <u-boot@lists.denx.de>
In-Reply-To: <SEZPR06MB69598F7A966ABC6664BD4724963D2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Subject: RE: [PATCH v2 2/3] mmc: dw_mmc: Don't return error if data busy
 timeout
Date: Mon, 15 Apr 2024 15:58:54 +0900
Message-ID: <008601da8f02$618147e0$2483d7a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG10PZhwJPp9GmYju4dCS4VuJkgUQFf5ku/AjsSt5QCamZEZgIyqpvHsXCiYfA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmnq7+BZk0g8efZS3+3dzDbvFj1RdW
 i7d7O9kdmD3O3tnB6LHx3Q4mj82vXzAHMEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
 6hpaWpgrKeQl5qbaKrn4BOi6ZeYAbVJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTk
 FJgW6BUn5haX5qXr5aWWWBkaGBiZAhUmZGds27yaqaBPoGLhU8EGxhs8XYycHBICJhILehaw
 djFycQgJ7GCU6L08hw3C+cQocenPV0YI5xujxLc5HSwwLbsnnYFK7GWU2Li2kwXCeQnk/DvD
 ClLFJqAn8X/RQuYuRg4OEYEAiScXFUDCzAJSEk0ndzGC2JwCsRIdqw+BlQgLBEn8OxgDEmYR
 UJXYdGo32C5eAUuJ3qdb2SFsQYmTM5+wQIyRl9j+dg4zxD0KEj+fLgPbKiLgJ/Fm73QmiBoR
 idmdbcwgp0kIPGKXuDnrIStEg4vEof7TjBC2sMSr41vYIWwpiZf9bewQDc2MEkuXHGSFcHoY
 Jf41XGeDqDKW2L90MhPI1cwCmhLrd+lDbOOTePe1hxUkLCHAK9HRJgRRrSJx6fVLJpj5d5/8
 h7rBQ6Lz20H2CYyKs5D8NgvJb7OQ/DALYdkCRpZVjGKpBcW56anFhgXG8MhOzs/dxAhOhFrm
 Oxinvf2gd4iRiYPxEKMEB7OSCO81Ock0Id6UxMqq1KL8+KLSnNTiQ4ymwNCeyCwlmpwPTMV5
 JfGGJpYGJmZGxiYWhmaGSuK8Z66UpQoJpCeWpGanphakFsH0MXFwSjUwRa26xTX/w+krMxkb
 /92tFrlqOM1B6aHWZbaotpnxN7uMQ39oHSxPrZk42ynwsAOf4/pjjnxSOlxWq9eYN+ocP+/+
 LVbOiu3k26tTLbdxzz3FtnXvW5WdhYLHTE9lSh979b5yUvd7006fq1FKjI4hh+tDvsX1r5he
 vthhtk32Q12vfEYrfa111Z0frBaePW3R5fXh2KR515u4uuoTWh+EWsUwFDx+aJWY6730QPJe
 OxXFn1v+5Pnrr/tkYCNjoa6Qfiw/oVlZKTGquSppHq+lnuIHvbmpew74bMzTqWPoCqrMd5Rs
 sAyN8/qU8Oz6/Pcnq73dSrXMZvn88Yj9uU/nZFqPZW65RgnX1IcJfEosxRmJhlrMRcWJALbA
 L7INBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvK7+BZk0g60zmSz+3dzDbvFj1RdW
 i7d7O9kdmD3O3tnB6LHx3Q4mj82vXzAHMEdx2aSk5mSWpRbp2yVwZWzbvJqpoE+gYuFTwQbG
 GzxdjJwcEgImErsnnWHsYuTiEBLYzSjxdtZkJoiElMTnp1PZuhg5gGxhicOHiyFqnjNKHFmx
 BqyGTUBP4v+ihcwgtohAgMTCnW2MIDYzUG/TyV0wQ5kkTnTsAUtwCsRKdKw+BNYgDNTwp/My
 WJxFQFVi06ndLCA2r4ClRO/TrewQtqDEyZlPWCCGaks8vfkUypaX2P52DjPEoQoSP58uY4U4
 wk/izd7pTBA1IhKzO9uYJzAKz0IyahaSUbOQjJqFpGUBI8sqRsnUguLc9NxkwwLDvNRyveLE
 3OLSvHS95PzcTYzgmNDS2MF4b/4/vUOMTByMhxglOJiVRHivyUmmCfGmJFZWpRblxxeV5qQW
 H2KU5mBREuc1nDE7RUggPbEkNTs1tSC1CCbLxMEp1cBU2vr4yvKtnzadnP1YU91L4eYvG7c1
 EUt+Hjq9RYtF5c8mm76Xk5tvb7roJTGZsWzJj5Ilk/RvfEj1Fil/xszEFy9kE3tQ53VL1l6N
 ozMPblGMXDjh7TmPp1w6ksfjlnsYGPxJrbw6/6NJiuecySEL17xcaf9usnG+6/cz8vu0FgtO
 5jgSe3o1G8NXs4oLQQ+CXDP89tT3cnzk7kqWX22Xf11KfZOPVu6fhZ/LGKS8C/WCXQvvrl5t
 LOX9n600q3iBteeqqtkVQe0vvttwzN8mNMHwZu2dDTLipU4RPyryQxpl7VdxlYZE2qqYL7sZ
 2S97gPPawwfbTJYvOxcr5CNnKvc14LLtw+e8h3UDLc2VWIozEg21mIuKEwHmkREx+AIAAA==
X-CMS-MailID: 20240415065855epcas1p331cb957260728d49f263f735bebc26cb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240403004155epcas1p1fdb3680cde2a4dee4325e22b9b076e6a
References: <20240201-mmc-v2-0-9f09dc1335fd@outlook.com>
 <20240201-mmc-v2-2-9f09dc1335fd@outlook.com>
 <CGME20240403004155epcas1p1fdb3680cde2a4dee4325e22b9b076e6a@epcas1p1.samsung.com>
 <908bd8cb-b7a3-4701-b636-6d96cd2d2472@samsung.com>
 <SEZPR06MB69598F7A966ABC6664BD4724963D2@SEZPR06MB6959.apcprd06.prod.outlook.com>
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

Hi,

> -----Original Message-----
> From: Yang Xiwen <forbidden405@outlook.com>
> Sent: Wednesday, April 3, 2024 10:20 AM
> To: Jaehoon Chung <jh80.chung@samsung.com>; Peng Fan <peng.fan@nxp.com>
> Cc: u-boot@lists.denx.de
> Subject: Re: [PATCH v2 2/3] mmc: dw_mmc: Don't return error if data busy timeout
> 
> On 4/3/2024 8:41 AM, Jaehoon Chung wrote:
> > Hi,
> >
> > On 2/1/24 23:05, Yang Xiwen via B4 Relay wrote:
> >> From: Yang Xiwen <forbidden405@outlook.com>
> >>
> >> As described in [1], some poor hardware or cards would fail to release
> >> the bus and keep driving data lines low. Ignore it and send the next cmd
> >> directly seems okay for most cases.
> > This patch seems to be same with previous patch, right?
> 
> 
>  From my observation, this patch does fix some weird problems and is
> mostly okay for other dwmmc users. I can't say it is very well tested
> because of I can't come up of other tests i can do except some `mmc
> read` and `mmc write`.
> 
> 
> >
> > Best Regards,
> > Jaehoon Chung
> >
> >> [1]: https://patchwork.kernel.org/project/linux-mmc/patch/1424458179-5456-1-git-send-email-
> dianders@chromium.org/
> >>
> >> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>

Tested-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> >> ---
> >>   drivers/mmc/dw_mmc.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
> >> index 400066fa99..e103664145 100644
> >> --- a/drivers/mmc/dw_mmc.c
> >> +++ b/drivers/mmc/dw_mmc.c
> >> @@ -262,8 +262,8 @@ static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
> >>
> >>   	while (dwmci_readl(host, DWMCI_STATUS) & DWMCI_BUSY) {
> >>   		if (get_timer(start) > timeout) {
> >> -			debug("%s: Timeout on data busy\n", __func__);
> >> -			return -ETIMEDOUT;
> >> +			debug("%s: Timeout on data busy, continue anyway\n", __func__);
> >> +			break;
> >>   		}
> >>   	}
> >>
> 
> 
> --
> Regards,
> Yang Xiwen


