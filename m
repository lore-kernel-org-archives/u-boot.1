Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0596D711C8
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:30:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2E9483936;
	Fri, 19 Dec 2025 00:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=icloud.com header.i=@icloud.com header.b="MTzbNUtG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF83180077; Thu, 18 Dec 2025 23:05:07 +0100 (CET)
Received: from outbound.ms.icloud.com
 (p-west3-cluster2-host2-snip4-1.eps.apple.com [57.103.74.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A40388003E
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 23:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=icloud.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuri.honegger@icloud.com
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-5 (Postfix) with ESMTPS id
 A76051800128
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 22:05:02 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 bh=RK/BZCJd7dfLl0HKdErbZxW6FWUw8WfZKUIwYJ1gwqo=;
 h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To:x-icloud-hme;
 b=MTzbNUtGkpMTj5TBSyEowU+X3uwDHplVaRtNqXn0QpbjIhJISXssMAcpj5f6VTr9Cn/FK/0bBgoKkCwy85XNLEHZlcdsF0mD6eQ2WnnlVj8XHFcLZl1vgGAxPWmoGOmnm4J6J6+NP7luN5lnx2MkV8h4iw6MQudTs88emlVO1MXzUCnyXSO2OMUZ91W25ziny6PpyhfSHKAcK6AipkrqgFMlAedWKHFJc0iaCFiFHNp0G88FDfVogMHY0NfXYcF02WTThiO3XjpxzCv7QBjdB0xfs4GMWoCyAapsZhCAJW0dj5FXvm1cGf8g7dwY4b1GMBje7/eZ40Vsv/Si9cPCBA==
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-5 (Postfix) with ESMTPSA id
 86ACD18000B3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 22:05:01 +0000 (UTC)
From: Yuri Honegger <yuri.honegger@icloud.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Placement of FDT in memory
Message-Id: <B157C9A8-9D26-4C06-B2F5-BABDFD7A8BFC@icloud.com>
Date: Thu, 18 Dec 2025 23:04:59 +0100
To: u-boot@lists.denx.de
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-ORIG-GUID: IBIcjpkvDhu7bx3dIt-GBoitMzz3YTbv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDE4NCBTYWx0ZWRfXxqv21HHvcda0
 s7oZh50a6kZvW9MCw6OnEkNC19wP9mguf6l1ZjM36Bq+j2W2YvrV4VZ7b0oZhQcSYLvLHqBBPRG
 KPA+CUMAcfOk800W74SHuCvvixq4aPAdR+ySCFDEU0GBYly+q7QhFhKkTuIor7dvjl7pHJvOSMg
 OtfSOZCBe/4qB7l6Ws/5sO9wRciD0R6awWkbOhphWhgZFM0lTmdrsm1uLhBIFHwRb9pbYcj0ClN
 om2nc+yj0OrzJX76P3YBvpwfYciKw2nYLQvHhe+vmQoS7I+no0gX2SLIOuDtdt1Ckbp/V+u6C9V
 muG3PJdgyMv6Sx/dkLT
X-Authority-Info: v=2.4 cv=aom/yCZV c=1 sm=1 tr=0 ts=69447a8e cx=c_apl:c_pps
 a=qkKslKyYc0ctBTeLUVfTFg==:117 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10
 a=x7bEGLp0ZPQA:10 a=MquUGpQHRscA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T-LVa3Hi2K__c9wZpccA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: IBIcjpkvDhu7bx3dIt-GBoitMzz3YTbv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxlogscore=959 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 clxscore=1011 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180184
X-JNJ: AAAAAAAB8AWShEVBSo3r0friaH1LIJ4z+ZJTh9in+AOOwzOPbo0kDOzntHANprDLXw7xhC4pbP8kFN+soDPSbslF+7HwTfIecAWBqNkjhLhuGnSa7XxrBQV4eW4nCmc7EYIZMAfpsd0Y13hQDTjeDr6MaOJOuTIMdCt2k/LDTwSTJHzEsJf0Hq3zLvAGqgY0HgOfAKT6cAn38t+LM++nV5jOAoUgjPljkeUv1C72JtL4peb5wrXFbtXF1wF7S2T6sbuJBVmfeRzE/1K2+afXGHyxM/e99QSbDWhdMTQwiNw7VNu4bDqaVm4Rs6QxIMWcKesZTmQlSvQZhO54bfKm+6qYQwwYLypsWTC0pLt5vqn+pZf/JKbhv4Vw0E35thvujIZe6hAHyv13TFc1KjeXqCHRIP3/PKmTBUlRhpZXLr9rfBAH1yaW9XBoBSpdipmDA5IjF61JoWjMzFtB95j1sVFN6ylXHiBgZpb+/e9+O7sngqZ1DlEcj4gW8+br8vs17H2OFQQXHxfQRCXRdfwTR2+GQyfba/4m9JvQT296buCcdlrz3/KalwwRWA14HlBA4oImirpzNh39tPlzz+dPQlrQjL0ak59xDR3GqRWljr+52w==
X-Mailman-Approved-At: Fri, 19 Dec 2025 00:29:09 +0100
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

Hello,
Recently I've been playing around with the imx23-olinuxino=20
(mx23_olinuxino_defconfig) and booting NetBSD using u-boot. During that, =
I've=20
noticed that NetBSD panics because u-boot places the device tree in the =
BSS
section of NetBSD. NetBSD clears the BSS section and then complains=20
that the device tree is corrupt.

Reading the logs, it appears that FDT and kernel get loaded at =
non-overlapping
ranges, but then u-boot relocates the device tree right after the kernel =
into
the BSS section.

## Booting kernel from Legacy Image at 42000000 ...
Image Name: NetBSD/earmv5 11.99.4
Image Type: ARM Linux Kernel Image (no loading done) (uncompressed)
Data Size: 11950164 Bytes =3D 11.4 MiB
Load Address: 00000000
Entry Point: 00000000
Verifying Checksum ... OK
## Flattened Device Tree blob at 41000000
Booting using the fdt blob at 0x41000000
Working FDT set to 41000000
XIP Kernel Image (no loading done) to 42000040
Loading Device Tree to 42b93000, end 42b99a0a ... OK
Working FDT set to 42b93000
Starting kernel ...

The bootm command seems to insist on having to relocate the device tree.

Is this something the OS is expected to deal with?

In the meantime, I've managed to work around this by running
env set fdt_high 0x41000000;
before bootm. Is there a better solution than this to force the =
placement
of the device tree?

Thank you,
Yuri
