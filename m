Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B35EE77183
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 05:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1353800D2;
	Mon, 16 Dec 2024 06:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="HH+xpX32";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5028E800D7; Mon, 16 Dec 2024 06:10:48 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2490380050
 for <U-Boot@lists.denx.de>; Mon, 16 Dec 2024 06:10:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20241216051041epoutp04f6b6b6c383ee09c0c5cf2db3ea31dcc9~RkCnrl9Ne0211702117epoutp04k
 for <U-Boot@lists.denx.de>; Mon, 16 Dec 2024 05:10:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20241216051041epoutp04f6b6b6c383ee09c0c5cf2db3ea31dcc9~RkCnrl9Ne0211702117epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1734325841;
 bh=/vp/wqXrjiWJ9Wbe+C4a9lYSgHNzAzaGnVJzArnOSVw=;
 h=Date:To:Cc:From:Subject:References:From;
 b=HH+xpX321iuNZZ0/k+3gSuTGJUGTRc7DXYGCCGf8WDq2CD9lrY5IMhI1DZwl/JRW9
 XTY2BAHzIjgAzDq2HZyM+xsFWpgcwoBMdLc3pbyfLHMy/jvsZdfrfhvqFvt5mo40N6
 e8GH9/GsJWcMY49NtfHybgdTNE+dEs5MRflnsrNQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20241216051040epcas1p42d5f0e5c59a4b02ba77a1371700a1a33~RkCncS2ng1645616456epcas1p4g;
 Mon, 16 Dec 2024 05:10:40 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.134]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4YBSgz4mxnz4x9Ps; Mon, 16 Dec
 2024 05:10:39 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 ED.82.31735.D46BF576; Mon, 16 Dec 2024 14:10:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20241216051037epcas1p12e4dcb7ac35bb120deebc9cd1300b504~RkCj3QtlG1494414944epcas1p1g;
 Mon, 16 Dec 2024 05:10:37 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20241216051037epsmtrp12b873263e4fdfb1050a5c410cbc706f0~RkCj2cJI43242832428epsmtrp1L;
 Mon, 16 Dec 2024 05:10:37 +0000 (GMT)
X-AuditID: b6c32a4c-4e33d24000007bf7-1b-675fb64dfc69
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 E4.D5.33707.C46BF576; Mon, 16 Dec 2024 14:10:37 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20241216051036epsmtip188df84e786efec7473349b227649618e~RkCjsPJQk1622816228epsmtip1p;
 Mon, 16 Dec 2024 05:10:36 +0000 (GMT)
Message-ID: <ec1e7fef-d067-4d7c-b7ae-b45cf788f765@samsung.com>
Date: Mon, 16 Dec 2024 14:10:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: U-Boot Mailing List <U-Boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, ronald.wahl@legrand.com
From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] Please pull u-boot-mmc master
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7bCmvq7vtvh0gxfLxCx6ex8zW0ydtJnd
 4u3eTnYHZo9XB1axezzoWsDscfbODsYA5qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwND
 XUNLC3MlhbzE3FRbJRefAF23zBygTUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpSc
 AtMCveLE3OLSvHS9vNQSK0MDAyNToMKE7Iy5qxczFnSyV0xc2MTcwPiPtYuRk0NCwERi4tvl
 7F2MXBxCAnsYJdYfPMsG4XxilJg5aQ8TnLN77TI2mJb1i/dBJXYySnx7NhNslpDAe0aJBYuj
 uxg5OHgF7CTap7uChFkEVCW6d79iBLF5BQQlTs58wgJiiwrIS9y/NYMdxGYWEJe49WQ+E4gt
 IqAn8fjsUVaQMcwCVhLLNxqDhNkEdCS2fzsOViIsYCjx+OYJVohWeYntb+cwg5wjIXCIXWLm
 hStMEHe6SNzuO8EOYQtLvDq+BcqWknjZ38YO0dDMKLF0yUFWCKeHUeJfw3WoL40l9i+dzARx
 habE+l36ENv4JN597QE7TkKAV6KjTQiiWkXi0uuXTDDz7z75Dw1eD4k1TY0skOCJlVi84SHj
 BEb5WUhBMQvJ+7OQ/DMLYfECRpZVjFKpBcW56anJhgWGunmp5fBITs7P3cQITnxaPjsYv6//
 q3eIkYmD8RCjBAezkghvjUlsuhBvSmJlVWpRfnxRaU5q8SFGU2CkTGSWEk3OB6bevJJ4QxNL
 AxMzI2MTC0MzQyVx3jNXylKFBNITS1KzU1MLUotg+pg4OKUamHQ4zBhfT5wQW1UQ83z5FF3Z
 Pfo9N5zOL8yQ3Kd4m1OvL3eumcadeTGcMaERDqteCi3ZuqBIrKjt68z8baUt4i+6bkxx0qq6
 ecC28P+fR3L3KwzeJOd0mC3i+OIQmXJtk8O/k61dk9d/iTy67kOm+/xllrpObsHT0vLf5h15
 /vPIS4lnzfavX5ZNbF684dO3WeEza6cv+eDBMPVI9P3dyruY49+9faF1OZLjZvwP9gcdpyvt
 3fl0Ni19KD9h7Zx/+U2ONQ/O/VX7f6fkZnPSnkcGa+v1mXiVWJSZF+Wtr9AXkPAt+Djfsv1Q
 9Pnrhc8yOruKOI61C0/094ieNdV4971bCqurX1uzTX88c0mQjZoSS3FGoqEWc1FxIgD0+USW
 BQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSnK7vtvh0g8a1TBa9vY+ZLaZO2sxu
 8XZvJ7sDs8erA6vYPR50LWD2OHtnB2MAcxSXTUpqTmZZapG+XQJXxtzVixkLOtkrJi5sYm5g
 /MfaxcjJISFgIrF+8T6mLkYuDiGB7YwS6/6vZIJISEl8fjqVrYuRA8gWljh8uBii5i2jxLmn
 l1lB4rwCdhLt011BylkEVCW6d79iBLF5BQQlTs58wgJiiwrIS9y/NYMdxGYWEJe49WQ+2HgR
 AT2Jx2ePgo1hFrCSWL7RGCTMJqAjsf3bcbASYQFDicc3T0CVqEusnycEMUVeYvvbOcwTGAVm
 IVk2C8mCWQgds5B0LGBkWcUomlpQnJuem1xgqFecmFtcmpeul5yfu4kRHLpaQTsYl63/q3eI
 kYmD8RCjBAezkghvjUlsuhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe5ZzOFCGB9MSS1OzU1ILU
 IpgsEwenVAOTZlG1jceXomsb0i583PldNXvu9GTT04peyT45TMFcHz6dnZWmWzGp20Ln/Im9
 ixb/TfZeq3HZ+NSvV8dmvGxM++nTrJ21ZqJo6vypS+TVZ9g9ePo+4r/Rm8SlLoZtm3YEqfT8
 /lB4ecGrwzI6T/muzki55blBtPTJ1cmhN1OuRj4R7v4yRehui3lhmNH9j+7CZgZmEk+UH95Q
 N7jNP5nDfrX+kopXT0Ov2y+0ejvjj135dXHZ3zHlTiYbVd7uSy7Wm31Tr49129qT+734Hfuy
 nu1kaJyf98gvQHrqV/M7+95d8i1KDzS0FvD8L3mC2URhkrD5xKd9bzgPt1R++ip546WmgQPL
 CY3Dc3tqIufdUGIpzkg01GIuKk4EAJy4ngvMAgAA
X-CMS-MailID: 20241216051037epcas1p12e4dcb7ac35bb120deebc9cd1300b504
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241216051037epcas1p12e4dcb7ac35bb120deebc9cd1300b504
References: <CGME20241216051037epcas1p12e4dcb7ac35bb120deebc9cd1300b504@epcas1p1.samsung.com>
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

Dear Tom,

Please pull u-boot-mmc master into u-boot master branch.
If there is any problem, let me know, plz

Best Regards,
Jaehoon Chung

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/23871

The following changes since commit 50334151c02077f16613b0a082d95640800ba60e:

  Merge tag 'fsl-qoriq-2024-12-15' of https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq (2024-12-15 08:02:46 -0600)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-mmc.git master

for you to fetch changes up to 822afeb7bf84ca1c9289a61ea99604b4deb8e091:

  mmc: Fix potential timer value truncation (2024-12-16 11:24:42 +0900)

----------------------------------------------------------------
Ronald Wahl (1):
      mmc: Fix potential timer value truncation

 drivers/mmc/mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
