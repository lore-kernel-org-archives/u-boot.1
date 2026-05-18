Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952CDCD4F49
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 15:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECC0E83FEE;
	Mon, 18 May 2026 17:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="SlNJTEXX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 660D784119; Mon, 18 May 2026 17:07:32 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EED383EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 17:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779116846; x=1779721646; i=xypron.glpk@gmx.de;
 bh=wkDPZnXS+CgvtvCzhT+HUO8aXnSC1nMJGXgVyiEHN5o=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=SlNJTEXX2kBhRhZXcAOur6lppjD8uxyb/1q5GD37PpLAvJLo3R7eo5xvgMYoDbca
 CqQo+aJD+MppD5aCgGmCyOm1uCmLcuWrFQHTdHZ6gRdmXJjojfRwGaexgCMdjrRWq
 qHTlrHez2XZu94abPKD7FHORpe4WS5Ecj4sX6VJj3ZFAtR10rYOv1QfJBW/cyoyoU
 fS6Vu/BjVN8V/JmDQ63KzTEamLHmced2dYxIxnnHFpRLFcDT71FfejmaaoxDCksGi
 ovZ8X2GZegRGfsRsiCDJmJf+BQ1H1DVBhxlfDkz067St1V8ZJynWJWNZpoQkyMLcQ
 Kf7v9aFCYbhWcJOzHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9dsV-1xU0Pj3Sq5-00tl20; Mon, 18
 May 2026 17:07:26 +0200
Message-ID: <3d17d2ab-6b7b-498c-b131-099096b9d8ad@gmx.de>
Date: Mon, 18 May 2026 17:07:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2026-07-rc3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EcZ/ZQ0qXQMe8Q2Oa3cJRSy6zglrlrQeBJ5iyf+sQJloaCyjW5P
 qdYvSQAv1Nie5K+arvNDeAV8XVaim27I7cIw10HLnkXKYGjkIJiz+vk3rpTbab0yiTnOZ/V
 g9GH4kgUfG8/WgTUUExLe15IsJuhz9NSiCI00LejKlbtKCvsf4j62+j1OeC3jh+9a0NzMdr
 UTzlWdYp0OnUbFID4LjYw==
UI-OutboundReport: notjunk:1;M01:P0:P3MLplHjJEA=;bH8j3Yka5frysyXKyc4DW2ElU6H
 slE76biNvkP65Bgqdk6SDWn6XsxauqBGfihL3Qcw+w5VVeuTG2ckd7oBLKshZN313slqlwH7a
 LIjbhCr0+VXH/L5HApJKIhsH2aIOTDemFo5ZNONL0Qu4L3zhReSFkRZ/vEkXXRCtdKYVx0a9Y
 J95DfVc8orDLyCiuGHsuct61WulNs9X68/j1J4VYV1h6J78Js/UM1epBzMxmuMv6knMd0JL1x
 ZzsJz2QeNuMlzyz1zf8oer/AYFYQFDksqvMV6B8Yc+D82VxkGSpO1Q1VO8E9rvuiI8ZLLjSwt
 ctvEWNS8uPBalE4tZjfwD8CgufLpnQkqhHM5LGIEMQxe0a9QgFXB+F8JQsXUDV4yZmazw3Ttl
 cxVTSAc5ZbdiiIXZQWWYmvzA1iO+zhSqXINesjLP5ZZVEyslNn2rL72YfXpDEcYuDSYLwwnZj
 YblQb7UaaBLNiXEeVftPC5kPMeyJWonBp5bTy7J9c7uEsgXXBNDTJXBZ9qKxa4Ghh6RcX2PVt
 dyMGrXanBkXb9p3inNYsrlXxiTxGWyYrlsF1gK36a10UEw6SX6KEdaFJcjCudqCAV5wrFqWsy
 RzW3zBZJAyZd2ndU2jBs+q9uWmcKU0MfXyXB9rSeUrnyO5ES+9P+P/zXMQOOU9waJ5MQ/hFHV
 uXOni0m9fA2I6dwBC8Re4l+Si5cYTCvO1xjvaGhPc8dQWsMk4jKka+jmSLvF9XjApzhGV8NAK
 OkHwPdhZmS9x2bapVVPuHfQbZuB4RZroqi5pwb8D9oDcrptSjkOCghgs3Z65zFzDupF7KI07Y
 XA+2YNYVqx48s0GwZkjUs819UhkSA2dtDvW2eAxLXJOFLaSglKghQBcWAqnX/NSEOhJ6Gd8vf
 CNf3qDSw9xjjdgoEizGhNLYExM/gJ8Zv/tcOVElRn6SuNrckrwL3luoIG4tNWvX+62QJ4Zk5G
 KLr/NeGkFuxhMl/NpxgGMqOjH2D6MCwq49vNA3cxnXmBZsncrksDMBkbJ6o05KYqTfwWjiGo3
 0Ub77uFnupGIj9jpMf1RLdvF0vGdmWaabr8PMOtX/J+za9tvK7hEpzch0ACJwDGDsgDIhuDaw
 N1+RnPhQNSXjcYU5FrA+OYBxvg0dAONZnRPaKbyeDN0G2eJ8apKi2lZAlFVm64O8RymtN2q1m
 N99q5a7QAdRFtu7nVpNs8WG9B2SngbLpL5Ja0UX4ND9HcW42kDsBQrFt9imRvqcMne6/fgI7P
 HBukkdKd61PM+uEt9Wad2fgFX0oPjqd4Qds8Rj0WNryrBYqug8DGY28zjRIuKFtyMLGSwjgVC
 UTqZUrMGAELp+om0CQaEnTRmDXq5tWAyXasYWGL3YplOhOpH91ceDuaxKSFgioc30VmZOrNEB
 01he7k0xAPp0klzt4NVYOJcy2WpOov0ACwFB4BgF5cuuqcrRl8XOy+mUsTSAkCexIHn9ETroF
 WQwj96YVrX3MSUxlKFpJzhbYY6cpMlETkoHbRd5+5+w1LfxDImLxHxb76dnTwjFDUobEE5IpA
 JsFDbOIjWTRz5myAWQmkFyh2W3lsmgO9SbQJcGvAYMj78f+0EbyBkvjAXqRcb2kOSBeDF+c4P
 7R8FsAqMNmEB5zLjy094mxAmXCApECESVVqX9wqsO7SQQiQclzJCPJI0flRGcPA+yySCX8PM0
 mbLXsNzqM/ebPhBgbpuWJc8UtbMLS1lgn1b0UakYtTMnIMbsBL0uvs3/qS22Kec5gKdPF5Ree
 8zCaHaVUBoyRUbGN/rqpUm55HiZG2Ae4CWLqwC9I3fzbWJfwTkvwgQA8zY3Ex8OYYfkxEJaa9
 cn3mE7OsUWliiwdgA/5CxGqq6tmSlBejVkvAo+qA/NwiezOH0uTkNgw0k6swUIV191qgRrajM
 0I4CEL1QVoASTMP5CJE3CeJF8nv364M8zqaQoMIP3IW6jJNl8gxB7Tr9K4z8uKqlA53ZGFdSj
 fqjfn7TRN+SRMsqyJC+8TevSqbqJVhYTJta/kbIvshIAO79ceDdF24x2NMYYsl4MeIyMqvi+n
 Qxj6XeXXFnN/f0urAn7onEpWApnv0112yDiRUBFaNwxcx5iKN88f4jzlNGXdKZVr9Gfw2E46f
 Fevud9Kgo/2whK+h+jLK/WcBv4cXKJsVqMI/ywapPHug45hGfu6f11X7yYn/SDT6Avz42bXx4
 y3MOIkIbhFKvP11WskIcxUHBjZ+gYq1CXlGAtmJscMCQZ06QmESEC7/JnbqXUs5k+EBu78G6H
 h1kTUNmkJ/CNUXccPi14nmBi+kr4RwDHvXsrnIMNBUfWNDPXXoq4SicEq1oy0VFz+CJ5Tt8d8
 m4/b4rKcMbtQLIjK4k9efmVF0DabzeTLES/dBSD+sYVYm7zp8FN8WBBjZwaLxhulGUHa/isro
 MzHf1nWtG4nGfVLtVXQLmyUVQesie9DVk6I5ffpmtTbkL8jMlCbZkxgTUtHrt3diLO/5rcnQU
 FDRwr0GzPdBJ7pglt1vE9BEIDw7waS9WLsnyi/3boo78HWt9O/xpei6qecquq2CwE5i2y/w8w
 D7W8LKA0Wl67+GgOsqsO5TMpbxi/Hq8551WJpmuvvXQGm4dRzdmNFSm2NaQK3yTABBiZAc70D
 OSkUVLNFNptmUrfU/fKtrliBhe5nQUEXIDC3Jqa7/D8YLNN09XmPiePqzPY/9v2xkBxBRm2pV
 JTUQ4vtGC4eR6mXwU6vifqakTRRjV5opxgoGgxt3mt0anSuIKUmD5rMJyvXh3PlAQrm0W+Ai3
 iqMf8WByEOVlChytpZDkwmc41lFoVuB36tT1UuAj2W4Es3E67q3gOu++Va5oWjRH4uj+7BMk0
 YX3O7bspIkw2aYYrZI01D9U7ZqjeUHxb082TzO6WRu0dfrw/FMBQIv6LriqHNt6FHlMWiJJju
 /+YCjFAS6g+wrXv+Al1L3OwTkHR1003+j9Gtgp0NmlthN2Stm1Jt0y8QN3V4yvgj19lX8fai/
 hl59r35E5o2Ip2jFGjQmFmDgsDWZO0fIkdlmsJRqvNZx/iRs3kHqjX3dosnhu5PFShDU4fU5I
 iJEUkrR8JnU4hRAyoRfC1wwKoUIsq5UK0uYqUgEG4vNEeccSW6HZiLi/xMYEM912BqE1FDLCN
 IAl9Mw5zWUQhACSjt7IwIwcWZwjmyz6JId7QrQm8J++7NnfWtIGQTyc74CcK0xYUXQ9NEgzbH
 MpIVdqpbRtq0lEhA48uRk/y1xJWA6VBfzL464xRdAJztIDYTwXubHPW9m1dvBhz0yq7VvqmB9
 HNYN+6sz12jsExr67hiufB11stQ6Tj1Yx8WFG32k0kj9f4Mk02MB6qsYFrEHvYp7uPlWT4EQP
 cfVeS2VjxrFXNwhYqp99HWHSnIPh5v13V28ggTensM4I8gvuaPFu3b83TB19fhEEJE+aIy4vw
 ZjfOPi3U0SQGpxIKL4+J/74goFQtMZCVn1zCQCsyGscE94K1qf/CKWXvQAcVXnp8hYd2daJAd
 SbW21wdMgTxGGuHXWeGJklseaXaa/NAy5oJ4w020Qm5/3jCm7VWWxWANZ+p25/KAWaX6MVXfj
 IGgZt+uGI/YSVfPoGNNJd6mUC7OVCxoHSZXGOeCfMc1TWLanJzoq38qcpEelyEdHajJcZbhvr
 ACkIug5OiKJq4fjgZNaCizREQawZhJM60O9CxYr0W3hFK17zsirAaJEqTRjOhUTx8sYjHD3oy
 vF7w+EgjJ0NLwb14mJRVu1O5ZKJbB9amlbTza7Ggs459lQdf+XF7stQ+0Sy3ef5WIgrUvMoOQ
 BKfFrk4/vawclMS4TgglkUCl8jgUOsI3KURKr87IBgTPKOl6MFMXEFs7knrZqBGVcjNbxGGPa
 xRJliQJv7RNxGg3iGcUqC67KrPZlGtcmXr6GZElzwsTE1laJZGheDemaQbQiOXZNtxo99q/GV
 2hXKp/ze4QLEAXRISnQ3hNSC5eb8fXdcxYJS+kns6HPcWF8O1R3vZNikHaLsZ1OjH+AEsyGYD
 ReO2PZNwKJPpzE36vk8D3f4PSZMl+MDXFP/LlzBnuhXKeSYMenKwkVcGanneraf9lMRCYMCla
 8mz+K6W+t3+2CxYEroxoBOWkPm/gMFOiG/7yTF3d6WUd/dn6EAmCKtRRNxkXRhZzqZfr46cjo
 me7UTA2Rh3up2+4JxkH2SWDpPADZlWkDoZ2YCHl6EB1MNIYtcrQhJjtdANhDUKa7YQAuAYgTy
 6KIPPYSkJEAW1kd7j0AYmAx3mrYbueNSXQ2e8OG2FxZC1PJM52AhHUN4kFeMe9W5gQ/uVHAfy
 R6V2Bq3I/d7+IFJY11O/zCeNcfjoyf0id/u/IkbiYEWK2QOZG5OTAUcOkkL9vjP09t+6sh51b
 sKrjmG0INB8aM6s19z4ZathFOfa5oEZoK7Vm9wavYjiK7Pr902lI6FZXWICE8xHaUUXUC/i77
 klJsgWWk4QlRnMFs6ceEtJcwfEYF1o+w5GJTuKpfdauzDUPe9zIgC4Gme4+7SdefXen8VLfhc
 LEk1XIdSoNXj4NJwyBR6IdtnFG8jXsSHW3DKzqydvnzXSirocbR7w8cIeWWq6c63ytiFVZV1X
 I2sYzEFWhgs0qrOudgas6mvFiqoVUtMm66zyYNh2JorlDwbNvOzP6v/m/XuRLMIfL0Z2YX+IV
 cl+MFX6yuiCgThyr0BHIgnMlbcSqAuohE5BsHRsmGTwhjz6FG2mM/47rqZUrsG/DtXeJBwxIz
 a19VWRQKf+Rx5979HWmqLPHHF0L2sRxRc1WzfMzBH+BhKtu93dauQNLacBPfsjko3yJxAi0XN
 KnF2HlmZSnbDil9laTZkxYMW1sp4P8QwTxXFjRmEy1m58DXYv0gw/FQqJuCGfp8qxuM7bQ/+g
 Z3DQvMYM2zfAgqblwttTSxSq7w2+h2fp8IHmPLf2fG1xr5nGF2TBlnzU7LAVY5bztJbHVutSa
 tIMT+5G73yWD3SQphf5kRxb1ZnO6dElLRpA6YFZqawC3+wXs8QmyWqdEguuGzTEonHBrqkNqI
 B+2MeesLn9HRMuriZZ7KrOI+lH1/KGgYPguw2LeVW2QQBgoJXcA/HgzAjlC5n7EGjkwaS0g+b
 OwW+9nvHHIUOZm4ws8swzwMwYIYhffkThmDmfBqtBftgIIj0lv2S30diRlfO/2TUZuSXZPPgw
 zqbzYm7gkt4hbWFV6VZv9sK6wQjflDmNB7ZtosTCAWBZ6QGr9Rne50w2c4O96caSAb9uhzKja
 CYixoXLr+tfJEoI5YG5g46ITVi467zb845G7muZ9vJXfiAlGZNsdb3+P3HGZRq7EgaZupNZtW
 cSX9/PewMMpqbS8hBg/OQb5YJySX5uctXj2Z6piGIhHiGp8W9Lu6hHAi4rIksksO76dLLR2ap
 Lqv110Swo2uxvmdjvZDoGILwAO4CvtRf5KV4bos91Ha9qYSpPgBspfsHjgD5LuZtwBiHLpNZ7
 LlF486JOSfoa2RsZXpIw91HsyHtKHGxHHp6uvO3frhaNRheiDBP1lqwoukjCdw0Ji5
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

The following changes since commit 215496fec59b3fa09256b4fb62f92af46e2ec7f=
9:

   smbios: Do not fall back on devicetree without valid mapping=20
(2026-05-15 08:18:11 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2026-07-rc3

for you to fetch changes up to 5824ed13bcdf4726c13ef76e8186bc145d8e43f9:

   efi_selftest: test hii keyboard layouts more (2026-05-18 08:38:16 +0200=
)

=2D---------------------------------------------------------------
Pull request efi-2026-07-rc3

Documentation:

* For reset command describe when the -edl option is available and fix a
   typo.

UEFI:

* If efi_allocate_pages() is with EFI_ALLOCATE_ADDRESS fails, return
   EFI_NOT_FOUND.
* Fix HII keyboard layout pointer computation and extend HII keyboard
   layout tests.

Others:

* In reset command online help show -edl option only when enabled.

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/30152

=2D---------------------------------------------------------------
Harsimran Singh Tungal (1):
       efi_loader: fix AllocatePages overlap status

Quentin Schulz (3):
       cmd: boot: fix edl being shown when not supported
       doc: usage: cmd: reset: fix typo
       doc: usage: cmd: reset: specify when the -edl option is available

Vincent Stehl=C3=A9 (2):
       efi_loader: fix hii keyboard layout pointer computation
       efi_selftest: test hii keyboard layouts more

  cmd/boot.c                               |  3 ++
  doc/usage/cmd/reset.rst                  | 12 ++++--
  lib/efi_loader/efi_hii.c                 |  3 +-
  lib/efi_loader/efi_memory.c              |  4 +-
  lib/efi_selftest/efi_selftest_hii.c      | 67=20
++++++++++++++++++--------------
  lib/efi_selftest/efi_selftest_hii_data.c | 12 ++++++
  6 files changed, 66 insertions(+), 35 deletions(-)
