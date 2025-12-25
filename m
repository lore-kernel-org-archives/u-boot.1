Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF3CE7AD42
	for <u-boot@archiver.kernel.org>; Thu, 25 Dec 2025 10:13:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22C4584326;
	Thu, 25 Dec 2025 11:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="aNxBWTBF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D66384329; Thu, 25 Dec 2025 11:13:10 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2719842ED
 for <u-boot@lists.denx.de>; Thu, 25 Dec 2025 11:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1766657587; x=1767262387; i=xypron.glpk@gmx.de;
 bh=opRbGh1N4/KKsbFDHJ4Mip26B4BsSivwvBiorlGfkPQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=aNxBWTBFRd7Irer5loUMGjslULNmbuxAunZTjmxw0Z5ekNC4fUKutJxHpt9Q5iIt
 rHOeLrESdxKuMO5id8bfSPRfkiaQM2M4mmcdfqUYFyHX35T/1H/wBG5hIf6Qu3sJc
 0pTOhgIbIFNccYdjJx1qWpMtQOXPBam0FbSXhoQnGPft+oGw/vzfGkPODP86I/lX8
 j/QLRtvxGW7TC2u6G05/zobR0wT3tq2zaiiQriReelhMd8uJraBO6pBEsd3kbpgv4
 Qx+mxA/L9K3s+alh1E6/nWp45j2q/kYViDQ+7U+vys7gE6yVH4em0I9dFV0AuwNYZ
 A5lp2CwH8AQzcgDwbQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N49hB-1vz50s1PMn-015mqN; Thu, 25
 Dec 2025 11:13:07 +0100
Message-ID: <1faefbf2-e8b0-4c94-85f5-025355915e0d@gmx.de>
Date: Thu, 25 Dec 2025 11:13:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, E Shattow <e@freeshell.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-next-20251225 (for next branch)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X8yes3/+E+8hZ7Q8c9eeRtMTDMEuoS49Vi5bcDqoAdePqPanHaw
 vTRjwyyeBXYznC6k35kIyfsubUGIIGjVIddLJQQfnXargSZVQk0cmjqPeF7vIhxPi9Rol5G
 f5QQWQCmDX9nOTqwZMMBNNFLIhb3A/qit79llpDOiUQhCr+N7u7Z60WIiwokBjZbztOjhS+
 VkuSIetCU5m0blx15Pfmw==
UI-OutboundReport: notjunk:1;M01:P0:YmLuEnsLvEg=;4H9D4hYfSzr1RzD2P46DM5PJ6TZ
 0JOAxaIyQv+KcJXnTS9JPyoJ/XXk9Lbp/g8Vp7OsH3fDHPNy29I3x6rYGU1PMMM0nRn9DInY/
 kFdcgD1+peTsHS83O+s2h9mcoycCYFSH7AHgLBPEDBfDgZOLuc9mBNQYlo89t8vd4sTb8tP2d
 RYwO+Jss897x2Gkg5mzXUaZ9Yf4Qx4nr4bBjVWz870jrRf+qhzmu56w1YxMA6K+Ox2CsQVO9b
 Ase2mDUZH+PXcMKk0sZQ3v9wQ5rU//1Qchbt3uq2eg8pwanpkmQL0rcOD2FChZ2JU5nkmLOEU
 Yu7iTBLFXeMEomToKo2xscSqnGzqzHKGS3WiJ5ZEUo7wzedjwrGfz6jxWI6c+gk076t4EqUwK
 Luomc6t1/n2eaT8kSdSSeOazUvf8itJFexdc22gHm6Sg1NayGtE7sHNTk84FyiEzOsCzDxYL3
 4ThwNf9uVIqCc1wOBcUbrTgYYQLmyYRw+Gp4IVMCjW/d6Y1KLblC/CVlEYqrlxv9wtQkV9lAs
 PI1lAIJiLq8vzT5CZrK1oY9a67JFXSrxIAyC3CnufXG4iIJyh01d0HThXAksLOgqliA3Sj6Q0
 Q2UhF4nRjm4zZOC8RZgYEDNCkC3eYkfLLzbSaw42Z6iKwYFht4PVVIXlPufDPOUtSSg2rbty/
 Y7CyFICltw141znSG5zzJzoGjUje46CV/mUEAUKOMaVhK7Pwngp02mmySgr7JmRTQAq0sAtBi
 Jn60RCcWzQnVFhau/VhF1zKuLZsTCzfF4Dicev1U07JHvkuiGsrV9BSUYxBcsi/SKdCFC83sh
 F3xPKQvLcxBHRx2Bbxw9KZr2TGMMsV9x2XnkpOFA666g5b/G5RZ/zbXaRgGvnSBQGVbXR3xaY
 oqvyZt+Ss08mXHRL7frALPB+36vNhdWqfVRrOt5/FtK1qVH4HqTQhC1W6TrbjESFDXfczZtUd
 EF0jKBM+SuSN/+SigpAsUvU8tTKLTAqZEA22IfrzA3IuFbfttO8OvIbUP7ATDODrISTfMQo+u
 Y0qreFnLNclo/2AzeVLIQWiuti9KvpiPHnRyXQwxvE1NFdketMeY6uXTWlA1Ya0Ro75KluIdS
 Ou6u1mQuGL1nX3lxgXkBVyWdAO+Vzs5yEifpWOGJYsQaC+4bb9+kF4miSTJ1paRyupOBMYbKf
 cjofWjwEiX9xEUm/+EYCZsquIEMjS+zJHOelAZx2DueWadj+PH2w2FKrOxxB145voCObKSg7i
 vuE/wASQKJIkSbSYKB8JVxmD4+tRJ8K+T/oyordhWdHC62Uc35m5nLtUvI+X71Q345HkgNt/t
 PHI8RuvuMwxx4iXwpDZn4pgIS+zQ/M/hSAiwELxbKPZBxK/S+2L4pO4qeR/4SmTP8ODu8zJFG
 MXn8vc4s7QVdp/fXtz6CGSyyHzpJGXwJgyviT02tDsB8dcxEPWH0rfeKf6q8v89zPyPs0oM/6
 uIekt1wLZSI7rGpSUofSQiVr+I2f5IzUgSAPd+IBVCtCGhH0lzJYDVRgLRHHCv77PFwNvLcX5
 myBNZM5LZxKd8vYS8dISyce6VVubMUDXcI18IaU9yjngtTWMzRNCvp5VN4QcAFk+wf/Vebi8R
 g1WKMRdn1ZW8IfBAkSmxAgAmtE6dToplTrnaSLXXSJ+hS9ZOAC32OOaqeiWiag2nNwvE/S+UN
 4S39Oc39F8+0P0U0qeJLvHG7H6YFuop4C2pQ6Of6Dzldmu7slS9hGU8lDH80V9bdJ41OWIEYQ
 zhcCYdXVctD2TL1JokJJOpWNPRGXI9SiL7/1zzctRPelQSQPETGn2NQWRCvvzUo7+rQj2vGVv
 eqD5gER1Y8KZALOkAiiu2FYSZWQFUBEUnssXohJj5TNAyc9ARy+gsKe6t6lVoRX1iJixpZMC6
 JAciZ0N8BRtE64loOY5mQ6HBHXxA6TXaR3gaI9OIKJCLXzNqjNcB0hRAKiBxQSjUJZs25XtHH
 V/vtXGa3gOMUAFp7YMUacRECa+Jw/8nxsCSga4oQuXUxbyevr8kIzG7RrMkH6nyaEjzCgg4yr
 XYzz9AEJVOafDlIf44aQCioqcZmrki4wOrbuyEGUrUl6SNS4/wwrt+AKpR6zwZU1EV8cijlsp
 uOKeEMPthOJNwVPpakSqQdvcuMRL1l3nqHO8r22vbVTlDLTQP7mIDIGdFFWRmoOWPzoDYmixh
 tA/NJnUJTWb1TLRl9eSri7d7nQ9ugUp53baYXk6jJZDhyKry5ntgNKwg6Ik/mbhBQIPcSTw9J
 tceazPsxnTU1sa4m2gemz0uxerVlKk6u6zqPPEVk11c0zcTynPXxCxcI7I/5Ie1lADv8wCiug
 MlNURTb4fOKGAFf0+iYrg8AklcBn0Bu4VyNKxsmR4Yhqh+xZz3t+LWa9X4vBjk3FJ0jdBgv9e
 xEPq8rBY87oudoRPtu5eRlSmD07dMad4VW76oEWLujoVCzDhE81RR/dZiHeyR+qJzAjjnFHwu
 2G9Hxxwgsy3PA7IQu1lTZtf1pF6pSUZ5q7c9rzfzJxcHtBObjt3ZVixFTda1hI1I2c80ndaw5
 vuAFeqikdUeZ0PuRN8z0sRVC53FY2f/yElC0ZGC2pr3RgFpE1v4O6uOI0Wj1PKmgHnyW6OxWO
 OXKF3XH/mlYSIO80Gnt16nKBSTU13s0nqEZUVoOIhPVZKaTEIyyBz0/MRzqajHuLo0SLYNN8B
 eD3imD8YzgF3Np+YMGRKtELsAzk4XR5SwuRX0HpNAUFXqvoffJeQBr4IJuS68GQnfryAFQ9xh
 eBNG6pmzHL1H1h7N8E7w+NOwWw4lHPRdWO1Zgw8lcif50yK6UZDfPCRYyg5yPe0n2LL3cQWYK
 GCAHmiA3aOF+IaFJS7OaJdXBmfGsQPOlR1Xk30Dp2IB+2EB7+SDowrfCGQmjIEDbvqaNT7Iuk
 /0/SbSLuFvsOij1jyoCxIvv7eSOO9Be5DCTmU2qJKzo1x+FUlN9wrw6xVLwp4ZazcOmQGyFIg
 1hOlG/NYBA+hEQu9yMtFjnxLywfNWQot36VHaulLrJPVJovYF/aPhlQUkSnYcTiwykf41I/eM
 WAkjujLD+lxRl5BTsnuj+pX6gf+sUJfmeUTk0Lz/+A4veqRS3JahkDQAfnhHlthlpd3TwWj6Z
 gsUa5Xkf27YUia/k1/mpkuckpQtLDPkIz4jI5C1yR2PS4qdrWeik1M8r1KhpSs1ouq+QJb80f
 jZPiiqymwvpSmGj7NFywkbviCTT2rRtPbgUqdg0RHPM7lJWu3WMexUX5IV179QlVx+eXky04C
 BfbnHCguzZNUjgn9YXHcaCoOXx2S8IROIKt7xik9GxnkmcjZ9Zr7fyK8gxWxBeZVT++TqHLuq
 JrbjtW9JRib00iAqHf8YWing1CmHcrFJ54tio1UoAUrIH/nTsi7hU6oZXbpkt45s7pZPbBQPc
 cKH5DkVyjmNJxXWEWFa6Ek1cqySTrnxSUY2ZNEO2YaF6n/c46SZrTGGertAeY1VQIYpEUOwtD
 1mwZhVKCn6zEA/MoGvsi9/bbQvngk9OFRAq8c+Rur5yAhvco/5L0GVk3xFDgi0bRES5xNasio
 0XRyT9Ur2D4jYEOrlv/wrXwe0vRdMH5ZTwFZG/rHwDeJPckzvp2EHY7mH8/cX37TIxrCowCWf
 Ff4Hmk8HvSfORWoeFqPFXLPCu+BuORUxVIk/EUxmIh7oA2A4Dd99ISrax9mlvqVCiRyc4XRRx
 a6r7rATagG8yrkZxoUjoqWjfhDsuW5saZgwRGPTNDIwBdbtK4Nv8F7k8CCb31/bBAEu9sEQRy
 vqUHabpY4hlHNQCEzoufQlFWLmeDlWCC5grLFEQ/JmN+/gQw+0SSAlBSB9qbcRUXqdsdSIEAO
 BkFL2zHtYRUUU2FZnzE6OxKqlaCV0KLvi4mu4agQ/rXiFBwfcLAfCt3qsWcH1w+FqZttI6+U1
 4xzxSWRKEtqqIlome+RJOpwazfVpkJN9FhCDIuEFkdwJCEIQaNzNUMBVKFoAZT78fGke81lWl
 NNDjVUYwvZVW5SRW2PaXDCfMxBUHavpMZZz+GUQglwLLG4wg3+3rkrcMQ8lsLqeENgfIwSXHf
 NEzND6c4CWbwRKTyzYLL+ZiCVvvxmDYLT1K5qMNgXtbQRsQUhdb9IXN8EOt/GoOv9gRhqCnhI
 tlJw66Cy0Sq45ydVAv1tIqJgQl1Q7nKm2hANtCtTFLLJ7gyY92Pf3F2eT8vWPybBAwTluggFk
 xGDXmDG6mJwFkLdVEl67YBdnmkBrXV9x+M+2wtAe6GlVSl/x17QsfPBSYWtxXEeasFY3GysXu
 VDn47SdloiOv8HhuD1hbSdSRqtK54QX0tdXSFdD89amMtrCEnP+hiI+CfX+djOXoZJ8l5DYym
 igV4eKqqByEwMilCs3rbayyYgreBtqabE1CrapsRtIcUkZxIl85bb83kCDATj+THhm9Xb1CK5
 EQINu6XRhcRnXik3wBWfoh8kxHenk9+ObL5+t3bwKTfR1xufFVPjfJkmQSAZ4v6Ho9Yx4CCEA
 DMQKG2HumUA5t1UJU+0MgrBu/zDbYnfj4sY0Jd5Kb3PxQPfR6KjQXCAp3B6Y3lZqgwWrPFh7e
 KHwJaejgutGHeBUcXy4MJKdvByWRvGHDSUh++4r10CnLxi+8KgVHKiCnNYtNxBp0cQ8qoEptT
 IE+W+ub3ZhskqAjLkozMn5OlP80TOvjRp9Hbf64ZCWco+jvbC6CwouC9s6dchUwjgFUOyyz2t
 T59N0QOLFxiYGZysIGkk5iSypVZH0wwXwpEuBWqBybSd8EUnx6TUeSCuu2bsDVXEPqfrnnSuW
 fZIyTdgC69AX8jm2EAKtKwgBCnQatrAZjQAHrHrjAyd1K2p74y8SRzOzOZSJCcdM+fDRg7uMY
 tNvGj1iNfH0eeNsaXxgleo5KLOdC2kIXHczrzr2CJU7/FuNrsZvyJ6v0xvc7Jvc4co/rtjpJu
 ghazKlIXY73EtBXdm0JFyGNEDMsArfv5cXZ35azJHRVSkfG4y0m72UBnBluRMq+e0CrbkD/RD
 je+pBn6BpOn9oiM/a0l5cvn4xuMvj3LXqxBtrPzP/3chABEiCFFpKeM9fB5PXpPRv9eMWbpez
 plFc2FJQzdZ9nQ+wQEnR/X8OWQ2hADWq8PxBxA+CcmJ4CsJb7cJgkNCWkrfSs44ewwtzkpmyF
 GeLVDsMT072rfr4HxZO2lIjz1ol0occhw4K6HXL0n19imWvX3LP/ZOqj4Z2g==
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

The following changes since commit baf076aeb32dcdd2b022405088c3288ffc160fc=
f:

   Merge branch 'staging' of=20
https://source.denx.de/u-boot/custodians/u-boot-tegra into next=20
(2025-12-23 08:11:36 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-next-20251225

for you to fetch changes up to 4c105d2ae7b0f847668ff1ef6b410f63ab4290b7:

   doc: board: starfive: update jh7110 common description (2025-12-24=20
09:41:57 +0100)

=2D---------------------------------------------------------------
Pull request efi-next-20251225

Documentation:

* Update StarFive Jh7110 common description.
* Describe command line options of the bdinfo command.
* Describe configuration dependencies of the bdinfo command.

UEFI:

* Trigger capsule updates with automatically generated boot options.
* In the LoadImage unit test add a check that device-paths are correctly
   used.
* In the variables at runtime test remove an unnecessary
   __efi_runtime_data attribute.

Others:

* Let the bdinfo command output device-tree information even if LMB is
   no used.
* Add long help texts for all options of the bdinfo command.

=2D---------------------------------------------------------------
E Shattow (1):
       doc: board: starfive: update jh7110 common description

Heinrich Schuchardt (4):
       efi_selftest: Enhance LoadImage test
       efi_selftest: remove unnecessary __efi_runtime_data attribute
       test: dm: clk_ccf: clean up assert statements
       cmd/bdinfo: LMB and device-tree are not related

Ilias Apalodimas (1):
       efi_loader: Trigger capsule updates with automatically generated=20
boot options

Quentin Schulz (3):
       cmd: bdinfo: provide long help with all options
       doc: cmd: bdinfo: specify required dependency for some info
       doc: cmd: bdinfo: document options

  cmd/bdinfo.c                                      |  25 +-
  doc/board/starfive/deepcomputing_fml13v01.rst     |  32 --
  doc/board/starfive/jh7110_common.rst              | 640=20
+++++++++++++++++++---
  doc/board/starfive/milk-v_mars.rst                |  73 ---
  doc/board/starfive/pine64_star64.rst              |  77 +--
  doc/board/starfive/visionfive2.rst                | 449 ---------------
  doc/usage/cmd/bdinfo.rst                          |  62 ++-
  lib/efi_loader/efi_capsule.c                      |  68 ++-
  lib/efi_selftest/efi_selftest_loadimage.c         |  45 ++
  lib/efi_selftest/efi_selftest_variables_runtime.c |   3 +-
  test/cmd/bdinfo.c                                 |  19 +-
  test/dm/clk_ccf.c                                 |  42 +-
  12 files changed, 763 insertions(+), 772 deletions(-)
