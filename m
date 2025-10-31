Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B26CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 17:03:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB2CB83A35;
	Fri, 31 Oct 2025 18:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="OwSmJnz/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7E0383A41; Fri, 31 Oct 2025 18:02:58 +0100 (CET)
Received: from outbound.pv.icloud.com
 (p-west1-cluster3-host5-snip4-10.eps.apple.com [57.103.66.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8E8483A13
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 18:02:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-2 (Postfix) with ESMTPS id
 037CC180176D; Fri, 31 Oct 2025 17:02:53 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=y3Ez+huFdExPRgP5rjXDG3pw0bbpw6PwCAlAC/i9WQY=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=OwSmJnz/SVyFq21qYcmkLKeElza4rkXGKkYPf2YmZtQ/UC4U9uZchNm5Rih7f5BZRjtEQ5P0i8fpDSyJhuwbpuwEiU7YxlqL61By3GHNljN5fWXQDfmkzq7NCE+ieZccITeaBdIslydZkaSkIj5I2LRtXpbij7s+FpAa8R5alab9j0q68zuT0JCOv+vImwEwd2WfsBl1JI6jaTiYk06lAXvryFxaHts54F6JzNOWrDJvwPzFeMJgSgBBmVnULi8bRmZKTUj2BTfmwkPlVDMj/l9UGfzA3/XuQyHfbtD5jRSPpHL321SqNDw4QOMUjp6jcfDjCyeePpFTb7UkJ1NvTg==
mail-alias-created-date: 1549370554000
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-2 (Postfix) with ESMTPSA id
 A16C2180175C; Fri, 31 Oct 2025 17:02:42 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v4 2/5] doc: bindings: use upstream bindings for aquantia
 phy
From: Beiyan Yun <root@infi.wang>
In-Reply-To: <6ca0b758-ac2b-46a5-a06a-5ef5ae676f00@mailbox.org>
Date: Sat, 1 Nov 2025 01:02:30 +0800
Cc: u-boot@lists.denx.de, Yao Zi <ziyao@disroot.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7AB9A75C-6A37-4DFA-B077-EEC6A6E9C1ED@infi.wang>
References: <20251031152348.60571-1-root@infi.wang>
 <20251031152348.60571-3-root@infi.wang>
 <6ca0b758-ac2b-46a5-a06a-5ef5ae676f00@mailbox.org>
To: Marek Vasut <marek.vasut@mailbox.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-ORIG-GUID: BrEjfGDBpOsC6JY7ncerONsCbbns1tnE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDE1MyBTYWx0ZWRfX+ho1kA8LsSyT
 eGqiEhG4j9ltKlib6/JmTzt3oJpBjDvqALDAnXL0z4caJoWRUvGHdNEU64wmyJ8t+p/ci63xod4
 YtzFaRYeZO3gdopAuY+ofXgb4IZgRphq+CmkrNCXw1804LnxgKVmcwd1yPLrB4glATaojYKwVh7
 il1hz65DmHwFpFvKbO3i2zc/IEa46vQ5NpCkjxrqE72JSSj9IWtYLgtQ7CUSfnnq5rwTroM6Kj5
 nuFEJLK/TCfZI6T4/Pctg+NcU8jW/AAv2whhNObydXYbivtwi0NOzCWIf5PV1x1O9zo86ISuA=
X-Proofpoint-GUID: BrEjfGDBpOsC6JY7ncerONsCbbns1tnE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=981 malwarescore=0
 phishscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510310153
X-JNJ: AAAAAAABrWJAby1lHBboh21rr+fUsyA4GLMec4LxtKloxvYrzEnJLfmEhWqoKOh4G18YVeomQpO463/3dh1opu1Hcr7W5urHwhpQ1+59HUnFjPU73GAuKc4Fr8e0QZliLx7lKrPSp+SXBdSbg/L3AR2qOAwhXwulVIIZ5CEy0HzaGvwkSddiRkBU3oy2EOJ6LP2z7PR2n6TlHBewj0w8C6txNS9X7i6Ce5tcrw8611ma/K07ZxGxwKpG1GKn5wbAkRs09xSW/4K34LPLMeHcXqCxauxQg+RZzTxBJJEjitNm23gNPzjEv+zS8bOqu916TVhr3pv+/blfllVhUWjQPgwAsoq9ALXgxeZf17dGP00qXepFuDVdnKb88WGTTuzSyjbNKqBkYlelhYSp6syymAMNg26EDaTK+kvg/jU6vE6EQlG7HnOBGrBVjZdlcWd/Lgxqck406MLXUm6SOimMUSNTcu9yBg5efCbFf7tMCEln0ExaXTb3lDUdzANfPvyXuneCGg9AGJvUS+AP456c+vyrz0ikfM1w4sGKjqG5YAsTtfjWslDq+k4LEqPTvgELqdAHT2V39xYZCDAxkuYocvBe2xhJan5WH0wd1FCAElCKtS0rIqnJ6I7NDpGPllurqIEHWVM5RHrLa1GEojuXWrhEjvZIHIiQWg==
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



> On 31 Oct 2025, at 11:53=E2=80=AFPM, Marek Vasut =
<marek.vasut@mailbox.org> wrote:
>=20
> On 10/31/25 4:21 PM, Beiyan Yun wrote:
>> Prepare for the switch to upstream bindings and generic firmware =
loader,
>> remove reference to upstreamed bindings, also add a firmware-name =
example.
>> Signed-off-by: Beiyan Yun <root@infi.wang>
>> ---
>> (no changes since v2)
>> Changes in v2:
>> - New
>>  doc/device-tree-bindings/net/aquantia-phy.txt | 15 +++------------
> Upstream bindings are in YAML format:
>=20
> Documentation/devicetree/bindings/net/marvell,aquantia.yaml
>=20
> How come these bindings here are in text format ?
As much as I=E2=80=99d like to, aquantia-phy.txt file has always been a =
plain-text binding in U-Boot; I only updated its contents to cleanup the =
upstreamed property names. Converting it to YAML would require a larger =
migration, one preferably upstreams smb-addr and eliminate the file =
entirely.
Since I have no interest, and don=E2=80=99t have hardware to validate =
the smb-addr quirk, I=E2=80=99d prefer to keep the local text binding =
as-is for NXP people.=
