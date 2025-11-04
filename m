Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6D8CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BF2583623;
	Tue,  4 Nov 2025 19:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bryanhinton.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bryanhinton.com header.i=@bryanhinton.com header.b="Y6Siv7aQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D0618144A; Tue,  4 Nov 2025 19:25:48 +0100 (CET)
Received: from outbound.pv.icloud.com
 (p-west1-cluster6-host3-snip4-10.eps.apple.com [57.103.67.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A4C48004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 19:25:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bryanhinton.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bryan@bryanhinton.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-6 (Postfix) with ESMTPS id
 4297E18008C5; Tue,  4 Nov 2025 18:25:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanhinton.com; s=sig1;
 bh=s3FGm7O8a9Rktm/ja8T0WwAMr9FpKcydo7b/yCW85o8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Y6Siv7aQbUtdPjR7UiJfF7vLe0QIxWMRF7Va131R8oGqVraCPjWO1rxjtjrrvwYIpu/Pz+Ndda8fsKft1l67DPuz2x8sFcTFcp1o21rGFyoLkGF4uu7w5mrukwpxJB6F/OwFAJEuSJO1vp2YJDjZ7mIyLIQb9rePadZy8euSfowLPigemhO2BK78COogO8IR0y6LnUnrnlWiDUbTEoIotvvEEib4BWlMerPjQSSUsdKtF0lsrwQjZs8PB82uCvEhE4S2tF2i2V/KAisF7yjD+S6L2uc01fBCxKSeKADDUzswMN2S5+lK3IZgDH8vtF0s5L3VpJhQ0lpQ+LPUrUBVRw==
mail-alias-created-date: 1643268037438
Received: from localhost (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-6 (Postfix) with ESMTPSA id
 C02051800E1F; Tue,  4 Nov 2025 18:25:40 +0000 (UTC)
From: Bryan Hinton <bryan@bryanhinton.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Bryan Hinton <bryan@bryanhinton.com>
Subject: [PATCH 0/2] Add Radxa ROCK 5B+ defconfig
Date: Tue,  4 Nov 2025 12:25:10 -0600
Message-ID: <20251104182523.2142120-1-bryan@bryanhinton.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8IruhMn124RteTjWocilEYOorvLAAE1n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE1NSBTYWx0ZWRfX6VL+A8GFiP2n
 tSnXp0La7HGNd0WzXVDu4jJS5jztMUqOyMQ5XDo8SVEESg8i77D3MDusmv+xVeXwvdfML2Qnp42
 whVKLejtOeeO1tGLxKVkrcuk7xzvsG8fvrD7f2U/plQwaTmxe1Fqr1QguVYyc/BS9pctO/XbGIn
 OwNAEZ3zFcUrDGTCSkvsvXGIH3HgD2RWp1/h3e7qFmOOY/y+VOwdUKh66PkPcrY5jXkWF8ppjXo
 ipzhCmjEl6qvdGnDMzUbJGGeB7q38h7mKq5MXYUj9KcjL4Z9zA5uHy/oRw3PG525+giEGdXds=
X-Proofpoint-ORIG-GUID: 8IruhMn124RteTjWocilEYOorvLAAE1n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=352 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 clxscore=1030 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2511040155
X-JNJ: AAAAAAABLOzDc76m7SBfG5eEv9oD65NQ+jdG1P5zze5Lx1oCSjzoohYLYy2UNJdRVbfnme9acHKJjY069kKcRVie1ymA0P5i+ZXtqEaY8TzDrVJV9FI/vCotLPUAWGIAi0FUtMJuGv9fIgQBRRSluFb0YVu3gnwG0/m9j0CacIyqaTa1CP4FxSC5NJSRq61jvYVsQGx2pKrJ6eDJ/cBEFJ2ZHWJkGBfqKAEltq53C+zBY4bk6zNNwO3F2CN2VrczS6Oi/ZjGImg6btt2ZykRxos5AK8pWE1bicVXa+PPRgEk98Ra9CSaYdSImOXjkDH9iSQG/615sarXGc3eA/qmtk7G4yJomQiC63J95YHk7BAsjP+iAE6czb19eIOxjMmiBnx+IBPj4E/6rwu0JgetwViVRUQdc48RXgSTr54ZGTekpY61z8NdNv0VIesrIbiyi80wEItXweikr0f13KOxpUnrO7hOoSNxTwXqzC72buN2VFSGhskvoCz2hOYXs3CFvksbDNmuuDChGLNkkl1r2BqiIqGd42yM67U9VxKU6DrYPbqrjBs0nzx8vX1Zh/g4vMd42xjyCSf+bo9I1HSoyQqRb2MHnG9ktu3kR8S2N3flBJ6lV3q3+Wz6+4oF0o8=
X-Mailman-Approved-At: Tue, 04 Nov 2025 19:32:08 +0100
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

This series adds initial support for the Radxa ROCK 5B+ (RK3588).
It introduces a new defconfig that mirrors the ROCK 5B baseline
while building from the vendored upstream DTS snapshot
(rockchip/rk3588-rock-5b-plus).

Tested on ROCK 5B+ rev 1.2 (32 GB LPDDR5) booting U-Boot from microSD card.
Build used:
  - TPL rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.19.bin
  - BL31 rk3588_bl31_v1.51.elf
  - GCC 15.1.0 toolchain

The eMMC controller enumerates even without a soldered module. SPL → U-Boot
boot verified; SD and USB enumeration work as expected.

Thanks,
Bryan

---
Bryan Hinton (2):
  configs: Add rock5b_plus-rk3588_defconfig
  MAINTAINERS: Add entry for Radxa ROCK 5B+

 MAINTAINERS                          |   5 ++
 configs/rock5b_plus-rk3588_defconfig | 118 +++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)
 create mode 100644 configs/rock5b_plus-rk3588_defconfig

-- 
2.51.2

