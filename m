Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BF1D116EA
	for <u-boot@archiver.kernel.org>; Sat, 29 Nov 2025 03:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 194F3833C6;
	Sat, 29 Nov 2025 04:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="UphPu6Xl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C0128352B; Sat, 29 Nov 2025 04:10:35 +0100 (CET)
Received: from outbound.mr.icloud.com
 (p-west2-cluster6-host3-snip4-10.eps.apple.com [57.103.70.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2844832AD
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 04:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPS id
 52F7318001C4; Sat, 29 Nov 2025 03:10:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=Ed63D+mKyBBOmzbNllZmuDJdkW06/krRpr4J9j30mzo=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=UphPu6XlkO6fjlIPL8oK5Li3sqDGPpyS5giA9PKI0VvXGB1w+gDwpD0GKC1dIxF4FI7FWlmL47rd+mCUlnxCU4gVprxxr1E64+kdGy1h81/vBd5ToLabmC6U75a78Ut6lUx09C928gmV0y10Z469VyqB1tmdjppZiUTuEtCkGw5zqQzWo1EL89VxN1hpThVLOlSksQd/1SjV2vGumUPpPGxzeNJNfbE9Lk0VMDFhknamLArA6fIeZmlR1kdc59DuZLrsgkngRxemhD053jHJ7RkOQOs93vEutmDuq/ESwoZsYD8PaOsWJKUzlgNtUk0mI/6i8+o4P5/F9whu4VbpDA==
mail-alias-created-date: 1549370554000
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPSA id
 048EF180017C; Sat, 29 Nov 2025 03:10:26 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.3\))
Subject: Re: [PATCH v5 0/2] net: phy: aquantia: Switch to generic firmware
 loader
From: Beiyan Yun <root@infi.wang>
In-Reply-To: <7e2b90c8-b814-4027-a7ad-9a0a5e747557@mailbox.org>
Date: Sat, 29 Nov 2025 11:10:14 +0800
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Zi Yao <ziyao@disroot.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A01442A-8AE3-4EFE-A8FF-34DB526B9176@infi.wang>
References: <20251101123401.110681-1-root@infi.wang>
 <4D63D655-F67F-4FC7-B02F-653BF49754EB@infi.wang>
 <59b26617-ea1d-4a65-a474-de16399f8205@linaro.org>
 <7e2b90c8-b814-4027-a7ad-9a0a5e747557@mailbox.org>
To: Marek Vasut <marek.vasut@mailbox.org>
X-Mailer: Apple Mail (2.3826.700.81.1.3)
X-Proofpoint-GUID: eoLr6pZx7nWd7ya38tCYTacJUPHhnTI-
X-Authority-Info: v=2.4 cv=RLG+3oi+ c=1 sm=1 tr=0 ts=692a6427 cx=c_apl:c_pps
 a=9OgfyREA4BUYbbCgc0Y0oA==:117 a=9OgfyREA4BUYbbCgc0Y0oA==:17
 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=b3CbU_ItAAAA:8 a=FV5MY-0hO6mp9yo-qYYA:9
 a=QEXdDO2ut3YA:10 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMiBTYWx0ZWRfX7K/bNigF0QgL
 ivcA+ZeUH8mMM2gmB5oLWB1W8XMkiJ4/9+GEMz/es1U6Mo9T9r3jrPqeHl95VYpxPtu77zTRWUf
 y3m8n5+8FkguYly35tV7xV0rhdIyInSKWjihWHFQJ/GHESLCCRNRyOcsRAxYot0to5lnuNOnTt3
 kIVjgS5UPyB26ihK7suqnf0s7o4++AtsP6QElkwk4j++dkptaYMMdUgR1iegO6GAfNyH41Il46W
 q61ONKAIuXRtlBvQ73iznAXLzpqzvvhwd5ea0usgdLbCT5uxDMBR5Ht3k7w9yoxzb5uG9r3t3ie
 gPEItBAEM7rYg5eOwlS
X-Proofpoint-ORIG-GUID: eoLr6pZx7nWd7ya38tCYTacJUPHhnTI-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1030 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=684
 spamscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511290022
X-JNJ: AAAAAAABwI4kf0JtmA5mzE5MbA8plmQOULYllkKQPycmN4OExeVcvNwJnTi141bj48/PbqsbAGabkbbBfEMNYgkKudkKRHG8hQxEOKI5aOMHpwybmp8Lc8d2Byk7Fue4iXIVVogyo0G5FJAdK4Deuc+pk52hfQQnN/1/mtfZWogxLOT5avkqrZvP2o89oGN942ngU37ZE8NE7JxWJqZSukssESLUSJMEnSlP1RbiF89+lmlW7eq4jdudLQgRh/EchkllY5d6ZzTstsrYEfjQRHQF+F0JAijMg0+wqhR3KYCr4XUj241CE/YuZMNhJXjM3scb0m+qMNeATARJPYJfYRloUCwDYdcs9pEiH4rt0ltc+lmvjbLbAu7W54ea5ftI5v0QVb/+1RaKxocGAHZiD+e1ZCGecQJz4/D6HxCEdWOpeO8bwKlR1MCskguA68Q78YN9bbVrAIpPTyk8rka8KZVSkQhDRGdl5VkGIn2nFhCax84kGnvtHkm7o4dqAxRZmmfV7v+SPzK58+KqIDBO+HMVhufixEiZiejUOGEPYrxYTUO/yw7zdx3FBQ87hzhrlkRygceD9+g9GyQvC6MGomNLih3JJLaoL6NmKc0hsBE6XlTwiJia+asQSVlSG7heYdkhus9PKkWIahdmTgPoDkrolbh0UrIkbLm6a/zQqedymDJ0ZtxAOGeTzqD51wn209hpcDuM2W20gCVqSPqoeF6GtN/EL0peyWXtIaUwQZI6YkQ/8JhOvVtQSPwMowfFjAfJT+93My1wQ+QJXVik+0DSySOXJXDrOQA=
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

Hi Marek,

> On 26 Nov 2025, at 10:24=E2=80=AFPM, Marek Vasut =
<marek.vasut@mailbox.org> wrote:
>=20
> On 11/26/25 3:22 PM, Jerome Forissier wrote:
>> Hi Yun,
>> On 11/15/25 08:48, Beiyan Yun wrote:
>>> Hi all,
>>>=20
>>> Gentle ping. Any comments on this patch?
>> Since there is no comment I will pick it up and move it to my =
net-next queue.
>=20
> Ideally the driver should use one firmware loader, not both.

v5 removed fsloader, only the fwloader codepath is used.


