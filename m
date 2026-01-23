Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165EDD7236B
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 10:29:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91DE483B32;
	Fri, 23 Jan 2026 11:29:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="oEvEZ1hT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24E3183B5E; Fri, 23 Jan 2026 11:29:24 +0100 (CET)
Received: from outbound.ci.icloud.com (ci-2002h-snip4-11.eps.apple.com
 [57.103.88.211])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FE0F83B03
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 11:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-3 (Postfix) with ESMTPS id
 451781800171; Fri, 23 Jan 2026 10:29:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 t=1769164160; x=1771756160; bh=StCa8yCS6IB2eZnURhZpk/o8U9k488XrBA4YApQi98g=;
 h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To:x-icloud-hme;
 b=oEvEZ1hTX8fwrdl0AZvUjVAaCwz6nr97ZeyuFOPhs3BDpO8J5W0Hx4LMD0WTjzOBBmViYkjQDhw1xPg/+pVrpJDlfAxC3cf8LpSRfI81ihg6BVfDLL/4aMraJfOBZ2mN3Egi5O53i5Q0T1KHy+tXroAZ2PvBgYPZjQUVQiI5BlL3HL+X4LEtPA43fKevh2/ycPuRefglsxwH6OiuWNKU/47kbiK2qyHeFDTFOUpi68VkvKmUyHaeNWGLbefnqZ02xPxr0GWj2iiCZ2DhaUu7wkrAPln+ITM1T59+o5QIWqfJISjzelnyXSQqI7MFArqf+BFH7OcUvSPiZXTIkaSiWA==
mail-alias-created-date: 1549370554000
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-3 (Postfix) with ESMTPSA id
 5F4C31800154; Fri, 23 Jan 2026 10:29:15 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Question about Marvell CUX3410 support
Message-Id: <A2A08E1D-EF71-4C83-B2E1-9375B32257F2@infi.wang>
Date: Fri, 23 Jan 2026 18:29:02 +0800
Cc: Weijie Gao <weijie.gao@mediatek.com>, ilias.apalodimas@linaro.org,
 jerome.forissier@linaro.org, joe.hershberger@ni.com, lucienzx159@gmail.com,
 marek.vasut+renesas@mailbox.org, paul.barker.ct@bp.renesas.com,
 rfried.dev@gmail.com, romain.gantois@bootlin.com, s-vadapalli@ti.com,
 trini@konsulko.com, =?utf-8?B?5YyX6ZuB5piA?= <root@infi.wang>
To: u-boot@lists.denx.de
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-Authority-Info-Out: v=2.4 cv=R+MO2NRX c=1 sm=1 tr=0 ts=69734d7f
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10
 a=1oJP67jkp3AA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=Zg8YGq9y1hQxktwvM1cA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: gCfS-th8NLM0TuFLw4rxXUREzU28-ncw
X-Proofpoint-GUID: gCfS-th8NLM0TuFLw4rxXUREzU28-ncw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA4NCBTYWx0ZWRfX44V+JADwbpju
 FVU3MY85+ZuwSn4Ttsn+txTiFiSV6vICDEjbvileLN0aI+gbHtxK4lOmFTlqah42KLorCCKAwQq
 4wyxOX+yBwxTzIit3F/FPqBQVoo1Th3xB4AbH6ry3i7SYg5dvjIWmXar1Ytzy9fCYT2WPjmaxnc
 ngFBTxG+2OOQH4bX5XIZabaRAGV1S5+3R42bl+xzEbGiXM4sEUd1le7FDTzOXjE6Y8mEyKrpgRE
 NR831rBPnYk1F5wKMUWnQE1e7GNVJpG3AWaIZjPtLvDXoIo0qOze2osr1j1IRGMMlR+GNMLaYpj
 XOIBG1uDdQqYycpkBUHkU00208P8m3udhO+MsWi7+ajEDfc4dRVS0PwI3EIn+A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_01,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=463 phishscore=0 lowpriorityscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601080000
 definitions=main-2601230084
X-JNJ: AAAAAAABNAvKvS9PyHIChaiJAKlVg9PvtVHEvCMYETNf7W/og0P/GZkhsWcW15GkGJWBQ76gzNq4zzpELwixh9GMIKZjXqXWU1peYT1GJRXdPVb3UefJKxyD6nyre1pzCc53CZhtiHUgD6hl5fVLvJHI6Wgxp/FbKdx8OcV9pXulDdZ12wjeMKWKn4u8u7AebxfnwYJ4quZ+b8lHoT7P1e7ucwuCI2qpE2Ehyc5iU14q/wJdxjclPxn05x0wjxirzhvHlH8aXiKtrop4SiVNA+HeLoxI4tiTg6BLCwrse52HHWmHG8/PoTtkqKfgBG88nsrahLXZPZ5oVWmkOmECn3HtcfVdrluW4mckprL2Mb+QDwVWefJH8XMIFXQPlvkQSGOyIgg+cUaOjHG1B/dF73eGuf2RDazkQmrqHgWXszHClE54SM6AHobl4xRLN3/gCWynVhPSGReEdF7ZMhljnNQTNrXt4MhOICwsXQ/51R+XaMq62NWJP9/0LvpLgOsnlQ0fCgPm4MC/rC9WFO7sSzJqqyiSpmUOrBj6MakGKSYjM8f9EcFZJ3uWPRl3Ly4eBZgnPBn7s03YImKO7AibByCz7Pcdnl7AjCoczVqFcEwejyI3qUfKiIH/Uwh+ZSgqrirB3ETMYc1iWAfr8WphihwVwUdbsnW1pq246sRE+ptiopyte4yfW+MCu924P0SdWTNgvxiSfJQM9gsvIR1P8hW+itYdLJTS8ZUIBI4x5QdnLt09biVoMKe7vCCD4+IL6MbwRU+5oyRVCjAlnpDSv816baitavb0T4bOzh0nMiQ11ANO3t6AbRQILUoc7/xgwCslP77hzCEuJEk=
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

Hi Weijie, and Aquantia maintainers:

I'm still working on porting U-Boot to Buffalo WXR18000BE10P. Despite my =
previous cleanup of the firmware loading code, the PHY still needs =
proper bringup.

I noticed a useful commit in MediaTek's U-Boot that adds support for =
this PHY =
(https://github.com/mtk-openwrt/u-boot/commit/7a5cf8f2f6d043ed6c9105fac985=
1e16b82a9623). Do you have plans to upstream this, or would you mind if =
I prepare a patch based on your work?

Thanks,
Yun
