Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EEFCCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 19:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95A00808AF;
	Tue,  4 Nov 2025 20:26:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bryanhinton.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bryanhinton.com header.i=@bryanhinton.com header.b="sl6H+ELW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9569A832AD; Tue,  4 Nov 2025 20:23:45 +0100 (CET)
Received: from outbound.mr.icloud.com
 (p-west2-cluster2-host6-snip4-1.eps.apple.com [57.103.68.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8079C8004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 20:23:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bryanhinton.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bryan@bryanhinton.com
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-7 (Postfix) with ESMTPS id
 4784C1800E99; Tue,  4 Nov 2025 19:23:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanhinton.com; s=sig1;
 bh=byIjHgqPhbwTpGAMOJwsGZIysqyC3b3REPGcyuoF7uU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=sl6H+ELWJTGDMykO7kAbULbEw7xKCat8rnrBocO2rRE8TQsdsiMZmyTcvPi8cyjQ1LVMnzVNSQrpOUrjP1CZCrbEY1UT4EsewM/DtxRm7fwWcjT8t7/M2KFjb9WAUw4hfxUkT2hTx8BYvqKK7xJAHuD3TmFvDp966jcuKancUhNa20Ee7cBWLHDYTXSh98nfe3BMkB7hPbHuKQmeNvlPPHVCIbd1kEoiJgwcGfOaBbkbdk4CGYCG4OBzLP14dGK4oPa1NLiEK4qGAMtb90H9tJcYVtKt4s+pHP4AI8Sj34WAPNSIl3vt6wIxQMUjz4b43jPH2fbEbTn9h7UnKh8MwA==
mail-alias-created-date: 1643268037438
Received: from localhost (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-7 (Postfix) with ESMTPSA id
 85BB51800E97; Tue,  4 Nov 2025 19:23:40 +0000 (UTC)
From: Bryan Hinton <bryan@bryanhinton.com>
To: u-boot@lists.denx.de
Cc: bryan@bryanhinton.com,
	trini@konsulko.com
Subject: [PATCH v2 0/2] Add Radxa ROCK 5B+ defconfig
Date: Tue,  4 Nov 2025 13:21:51 -0600
Message-ID: <20251104192354.2232191-1-bryan@bryanhinton.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=Ser6t/Ru c=1 sm=1 tr=0 ts=690a52bd cx=c_apl:c_pps
 a=9OgfyREA4BUYbbCgc0Y0oA==:117 a=9OgfyREA4BUYbbCgc0Y0oA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=FV9fdKxAccva9e2moXkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE2MyBTYWx0ZWRfX1eYIY0XR14ZP
 yJkAEMdX0cYhXo8qE4jdfT+RE7Xfws2O7eUk3zWYfI9d8sOFqLvbYBkTXJCN7O/f3TJ2q5MuQ10
 5lcMQJ5BXePCEaYZ3d+N1gaMWmTWDsZLEnBDVPCW57FNdOweelT5aOd1lwnoj8HNqs4USyPgDts
 NwRQn9C+3xT7nDN1sKjzvShkuLhGFUaLMfX9+Tu/knN2sE/8xX2t4dRJIYMW9disgSsjZYj+z/b
 +XCA50PVJfHtr1xLRz3XyLfNCoVjKqLoBOgrBDB6TazL1gdra0Zwhpf9sWJrAovJDdzi6MrGL/0
 owycADCJWALydWUoAw0
X-Proofpoint-ORIG-GUID: 69H3rwMdMGloTisBgGFup0fwqj9tNdSB
X-Proofpoint-GUID: 69H3rwMdMGloTisBgGFup0fwqj9tNdSB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=568
 mlxscore=0 spamscore=0 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2509250000 definitions=main-2511040163
X-JNJ: AAAAAAABZz6w1RJHO7rE0PAEqqwHkxfjAq9j7jnZORziAdue5jhlzKEFVFLCSMwFphi1DApydZrnROo4tLrLO6Tu9/58OiZJYQHp+ZOTjFxvDB7yFSCDX+nWe+m35l2liKpvVxULGZDuEXr4EC/Nlu0UI4At68J4cruAQW7pd1O7cRtIsp5NTIG/nFXne9j/lTT7iRcNeIcPaMYP2P+porCEjcVNwVIih1lwZgpC7V/hxy+aDJCNu4S7t/5tJFpS0orDL3+bbdhTe6SbWnUQGgtKklqPbwT+A58Qy5hx8ge2PwKHDshKYqec69kMs4n0HxoRLHj4+KSnK96/gbzRSxuF/ZJD7eRJDeWFn4MkZhalR8tVmtEBWKvDbNLAP7oh3G+2cK4tCqyqZ2fau/kyckypoR170zxlGCELyNRr3KGxiBeG+n/PYJbUr3p+fvH293OqXJrUiPxobYy1GQHLtAUnbeqIBx1soIRgLz4E8G0w+2LMW7805n1V65Mg1wQa5ojv07hQURu3zEvYqLj8Y9c3EqDSta4+c0USXLYbh/6k1yHI1L6dKLUg+oxlM6apooB4PdaEcPH2tp/1I4oPbPT/V2UdnIbiYLVkFfWrJa22SDHDsw==
X-Mailman-Approved-At: Tue, 04 Nov 2025 20:26:02 +0100
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

The v2 patches use #include to augment the ROCK 5B defconfig and keep only the
minimal deltas (savedefconfig output) to select the ROCK 5B+ DTS from the
vendored upstream snapshot.

Tested on ROCK 5B+ rev 1.2 (32 GB LPDDR5), U-Boot from microSD.
Built with GCC 15.1.0, TPL v1.19, BL31 v1.51. Control FDT present; SD/eMMC
controllers detected; USB enumerates.

Changes in v2:
- Rework defconfig to use #include and minimal settings (savedefconfig)
- Add MAINTAINERS entry in the same series

Thanks,
Bryan

---
Bryan Hinton (2):
  configs: Add rock5b_plus-rk3588_defconfig
  MAINTAINERS: Add entry for Radxa ROCK 5B+

 MAINTAINERS                          | 5 +++++
 configs/rock5b_plus-rk3588_defconfig | 5 +++++
 2 files changed, 10 insertions(+)
 create mode 100644 configs/rock5b_plus-rk3588_defconfig

-- 
2.51.2

