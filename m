Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C68F8E4A5
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 05:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8271183FC0;
	Fri, 17 Apr 2026 07:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ILg1dO3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4226841D5; Fri, 17 Apr 2026 07:07:56 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51BB383EEF
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 07:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776402459; x=1777007259; i=xypron.glpk@gmx.de;
 bh=3u9JD43tL+LF+DgVfHlqVBX6eJw/5vOTRwUOPCuowrM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ILg1dO3NS5vswoQXHHIrMwRVSP3rPVwEnc5MUDaKEzkUoXmKechaxr7oNJF923ir
 jQZFVsqDVx3EDuG63jEuxHxcl78gPOA6yK38YIdMgBFRDZoCOFmAaqtukdIEVSxDo
 O8/+AaRLrlDzIkGfFPIbg+s6KMRZdb4g8GSOTwk0VnpY9aakK/PJiB5e0u1mHptfk
 ldidm0R6rkQaQYhQ6Qpdn82xPkYkUIxKVHhyyNEgLe8evulg+4QbWnUcJjGlBX6g6
 crKq7p/duicBuziar/n3eaWiOASwNhbgAu8A8rrZpDWiSi2h3ukUbpmkCjQFOe2FA
 uJ3Z+Yl+0QItSuSdCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MowKi-1vdmi50jKo-00g236; Fri, 17
 Apr 2026 07:07:39 +0200
Message-ID: <e6d199f8-d76a-43b3-837b-5d9b08d198c1@gmx.de>
Date: Fri, 17 Apr 2026 07:07:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] doc: emulation: qemu-arm: add secure state steps
To: Johannes Krottmayer <krotti83@proton.me>
Cc: trini@konsulko.com, tuomas.tynkkynen@iki.fi, u-boot@lists.denx.de
References: <a1cd73a2-582b-447b-bb3c-e88afcf99545@proton.me>
 <20260224170908.GZ3233182@bill-the-cat>
 <37429ec3-d174-44d3-b113-bf6ce6d71096@proton.me>
 <20260224193312.GB3233182@bill-the-cat>
 <02e49242-da72-4bcd-a428-f7e8c9aee742@proton.me>
 <20260225004838.GA1593142@bill-the-cat>
 <20260225020042.20823-1-krotti83@proton.me>
 <20260225020042.20823-2-krotti83@proton.me>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260225020042.20823-2-krotti83@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WJjXJtupnroZl/CDJEykV1FwMZ4Cun6cS+IvySduXD5vza/zGtl
 Vs47tXwUspobeucqWQYochJUMEtgQ3skvSxqwI2G/1+SEFspHD5KwrZS9sRHWAuiMzwsdfg
 buNx6lQkuZkJyqkekAKuIzz2G5OTYTUZnD+93r+3rochPwWuFC8Rw0qLWlaxWnKXHmjdHVh
 T6gn0ZrzRShRFuZrms7uw==
UI-OutboundReport: notjunk:1;M01:P0:Wkf3U4Cmlqg=;5+5REBAb0DarQZIeH6xAOdF/4F/
 RzqCxr/TjtuNhQS/TAq55B3kjQYs1XAgUp0llUNV0r7f3aBwaB/r1r/lsvrZH/7wfyo386OYi
 auvhbAahXgc+KyJ/rYhkx6i28a9E9sbbvmLgOUs9LRCVQLz9ng9/77gGlplEEGuLL6VNXXQ6m
 VEYr8dfxzPxDhUAnz7NsOJ8GzA1Crt3KOGBMrq8TpG0wTUfzS7uIOiBJ4kHcP39WUHsv/ZaHU
 qB+1oInvyiiaB4q4bU8cacWMlTqIzK3jHnXHklCznWWtxs9sVGW14QpE17Zj4m3NQgiPfcTeK
 Yhh94bdloGPdK2REA1AnmdTeDlE0jZmM1GXpRsHONBMkb73SpbrZ5c7SsSw7kWRGXQxfpoF9O
 3fN8GikOUzfIwqN3R1AQoDfbtwSJ0yS/XXBehiL2Ppb0HHhei4na5o0wb/81Q5lURaKi0DzH8
 qNeVEd2s02Czks6HbrB4qKbodiJWW8Cz9UcnBd7ZgFxGKQJtXVL0vpaSQjS5aAx7iFCAL2fbp
 UpyOxa+/CsCp9oU2ldPdfUohJl5NZWDo+zb0aVIIgKz3q0UjSVfrL3aIU9b6cb6wUn0btbrNm
 K5Gn2ZzvLmq3+k5dqLb0HIny50GexbuUKB1TA6lXKy8bGU3ILpvt5Gej2SuI1t/A1TkgbQb8O
 fvEgr5XzUUMjPg28LTdig9fAHW8ut96eKowZHqTw7Gnu6Pi/74w2s7rTAYw9opv2+qcb4wWAu
 iS7/09uV+7MVM1ItLA+i5n6p52i5oapdIJOO34JUTp9Dy2CEo+9dTS84e1uY7WK6hYHhO4cZb
 foOMxKb8yd+eN90o2fKO0u/ZdtlC5sKMoXpl+HoZS7dyj0NchLYOpTMK9hq4Hw9KvdsK4nqSh
 Xq2M97PyqSIswlcAq0CQHsUpF4WAa193cPz5lIQCBiO7n46yPfBezHu2wiZTGfJAvRxtqJ2Ju
 OtJx1y+m0yRv1WL0kXNpx24q/MQYQGUK2WfET4P8FApfpCVhrmllP3b9lqq2oA/J3/rvgUMDu
 un2PmpzSoYzLBZx4//G57PGwPJx+c4ceSIeMKk+nZsMwuiapygJ/BBHypjQSwdP3yiJYOT6yo
 ok7HanUo6iC+TYlNXaFeSOQHqOEpgcMEBVyJpmlgUzvFkflgzHnMbK17qzhglfc6ZmLxGpEOq
 SGegDGLYcXd6YgR4yoFjXKmUW+FsdFkncPQCGsTA2Ps9wf+S2ZuXOywSg9AFsn2hKvLVagKOv
 GOT39sJ/0IHgzGAzdzfZ92+pZvd2csYo6qldBl6PWVs3H8n+GXZzmgu6MMbHWQvJHzRIg0aiY
 GZ3jwrT43QeXHSKhqO+8pW6HZFEWk7mzfEeCmi+Ihs3fY8/K/YKvJU8JnTuf88+rN4j98yLc1
 MMadJ2W47WWhDEuqshiRtEWXKsTi50u4zpiZ9/APGDzjMvPx0au0RlqDAuKivQUT7bhWIbzZo
 rYbxjES5ITBpBz8nHE05HW2dS7PaCNdL8DrXk7Ayqf9NYoZzV5FxlmEHozhnelMGiEr8b38DY
 58VgUbzJJGL8vGl+V7a9tEJ6CvrRg5lqrkaW0v+5xzhX6RQvKrOwEGzGXNgJGCbTxuVQDUEIw
 w61Ck/zmfaoVWxPQMpHLULlzX4M6vJLWbXRaOqDldAvKwM+2b9HArM2YdfOFFFxY5/EOB/wOJ
 9ceASdYfNACiJg5OtLTh+mhLkZ7mtQ51EnSY3MPUedhYEmaX/tqLnbo9YsCZm+SDRJFRARB5r
 R6YsNK80y+iGjrer/FS5upwUinMx4zE5twPBmEiMuCEfiBkcDaukWbaE7qr8JwLZVIK+fCJ4z
 RGG1DQO0lfH3CogKLTlcU/5+2eWCzdWd9EVrQqWPybO59oyeOW93SInyZtBrtC6d9jwwmHelV
 fAKBINQ2pXDctW+gosWyuAqlzA/9cdgqnUmRU1zFWbPtrtOqpOWcNwl+z+lA5ahpsNy0J1vej
 6PYJIDYB2DHkp0fcV1Ha4WOEEzz1myKy+RLiWidtIyvAtvbdilk+J1jzqwPJeof4EMspEaNiV
 aYBp6Kj2rJD3GZUAsvvUInI1EuHzb8xfMj1JmHpbclEeZNrsVVD/BWDjmJ/MJqzfNxCaknOoV
 gDtpGjRk7tb+Sp2eGhBerPHo3e83jO1uNdrSNfUBsVBznHLbkMCGrTU0qsIUtltFV6zrmTx/Z
 zkkdNY6LHrViPJkL6unPc9xFSGWbqn7brpH0inOn2V6WC5ZzZ/J1wqN99QKcw2W2nwGy2GkXj
 WsjhqQg1EbB4jx8Ac0B4fnOm1AsWCXt/1X3ynTE51tUq5JqD/5cUGcOsHjnctL2CT8JLjWvzM
 ZkW2OD9qDakDLOQkULFHU6ZIjXi7UAOTiVTPTnMwq2utcyYOS22bytMs6udQfyT5xlFHo81TL
 Zf45qDI6XOgu3dXEqsy6wLIGdHSh+pkrMFfexm+vE737hwrQvlfiKGHlGRGtQkbiXIn5G+E11
 66l6c/bhHJX9GodhHavPcIgemOFEFPGY/vwHic+wzqTJjOhUp/igLbq7IxAqgHCyEIM7UI2zm
 K6rRu888fl3WPfeRi/07OkqKEYxUUOFNLbyj2/p2rPvg9TLQEP66B/Lfqq6xMvC6HrzsOxAnW
 H5C2ifLatGXupExEc3UYl08gtiyAViWnw/iXhZhaqhZQawDopRS6adolEeObhm8Gp/39J+zP6
 qYwKNKgvU7PrXz2lWvqcSPUuKqFUbooAVn8sec2Dd7M2T2i0+S/JYuAMLzNBLwe+MfcjzVyKn
 UVRCCuvw+/5d5IT9g5KFyFhrDFGHid8tQcukXXlhyTRu+LFQuPXb2ooaGstxMxtLS61x51x42
 //fO+J9Y3XBCOfq8dDEgUOj4gBsntwt+qQlszNx46JUV800i7KZb5dvXABO9KEPWaNRQCeuaX
 6k1OXxhSwYQonJN+hJSgCdnRZfxmFp3pPW5uD7Kd8nFvTz87Ym3bp0ugUT7RSvO94JUwtZTXK
 eLRtzfYIINOq08VgqZUANio6PD7Bqflrjjg40cctss4Q22eretaiW8L8/5k+yzhAM1b8Og75N
 TYUvspJNeB+/T9IcaOa1zOB3m2mG4mj3PuXNm0glY2Guz8S5rSL9ySwkz9/5cHkzVe0zCU9lL
 +RLABl7NThOqFLvBoCUuYWfmcV/aurERmEpV5dIKm9LvRhqaOaChduxygRqo3TD0/6d77yw/5
 4jggHZHmeZUURYNFVbXsjpE0s0vXwEM+B0a7iFkWYiLU1tZFAIQGm6kHfiDvabu+RLmm8J1wM
 y+QKmyy88BowYPGbz06bzsafLPTtH2fmiLt40UeRIXby8EUqDZLD4fJTfgKTWaLKuj9Nhmxm7
 xZP+IQp9HHmxJBkzH7hjBSxfKH1Ja2s8HCtzf05FiEGX3dq5887bbFsV/q5CKUTfdl9X/neGG
 egwpbJT6GvYMDyCcZm08FUUk0J2FiQjizSwADDhYBdhf47r4PQVH8/+sT3GAVNYFfIfN8u5Em
 we1szc5AkY4yh2HvpP5hUEOOVwvwvsuEs4saPDyP7JEX6J9VTOSiIoMc1WgZAcAuNvi2ctff8
 BTcK/UgQjc9KkWVTUnV6qh1+U9gjbQ2GDN3pBC7VQDsRRu7f7TmDYhX4uy2zEhtfKNw+fTC8E
 8N1SkIRYIi4Ro1E2d7cH807EgS9Mmr4LA9aipJ5XzuSoR5GlHOb/cnWH7CBQq3nf0JGLnDtLx
 fB/MgQbgn8GTWqAjoDuH3XVmP9tGHYOQG/11KpjQmBj5sxD1+whiGxmRJFt/IQlgIrZGjWMqq
 Gu3MQimE6gM82s+J0vP7IspXnBgKyQ4wF3MyofllFT4DCfLA01eOHU8JBRt0WWVbqqy49iGSV
 tQk44C/Mx9zRsi4zjWCWdLPzTQ0M7Pb2cwZdy2R9UfL/SPP5ziYMNT8Q7sxiLpJo1PMxpqmEE
 uF3k3Zik2UwJdllCdYbME8GR19mnkNOqfYl0dipD8F6DeQfR4clF5+AKQPbUHz6uKKlZfT9sA
 1/BSjJpHTV2tIeq+LKo6sqChE6EwUjU3JdACCItk+04DgunXAiC14cDcKf4ZCCFKOscezxK6r
 GBeCMD6PcZ7GeT6T9hxGAOLc8AQWhyvQ3pqX5pVZqadYnLqeuZTeeAYhuvESz/rmfFi7fiMle
 1/lcb6bhI87aCAQ/+/xCqU16q3FHmQtoe1g0xN36VWfqj+T5vzM94WrNXfmAV9t6qDKBo0BF0
 +d38yzJx25ouG60WDudh5GeyYKhH38J2xoEfPUG7WkRo7f7B6C+KiQgPeIdgqdycUscNODI6K
 Ca66xdqrUZrGBMcVh7Pude1RL3cICPZchK4mk2GLd5mosGFjBwbeo8GOPOPUbZ4TpnLB6Vvdg
 e1x0Q4nEPZ3sZaPsX9tdhR81E8S+GjU3+oexfKF4caFKsWXCbjGQSLnJI8iGClTkAsdcOPOgI
 Qk+apXrGSwll0e7PjC9s/+FP6Do3kDeSihMfdNQW8qR7DuVtlnZx7QdRPhoYH3AnezAkpssnz
 1Y+fXZF0HTbrjvt2lyac+hi5OG2DP7NJQNiA4N6sR089lGCHKC6cQOQvtg6j0hYChdsAl5ozK
 SoKGuWsizPoi4sCVs5vlcRGVmhd3Tj+IJPGD3njh8/xXgROvXD6qJiEDaxDE5vwb89jl0Q87u
 uZrEEh6pazZR7tK6IFOTiYZlcCYx6kthYGoBD2+ETX5JIAbLajRpDVcHByJblX7BxhQT2ezgv
 OqzTszuuorK6t+b7vGQCsguNrxHqA0J00nQHwBlOhk2Unct9A83R0IBVfhRVH/cp3FfOpu6Oy
 p+zblq7tzrvpBMtlb/HFFTq7qWr4SeNH6/TEMyiB2HKOcI1bSzPSUczvTiQteL6wfWvlyRt+j
 lLNxmTZPQQGoqXvXAFJcJShsVHVbRmPk9luwVccbPy3fVIQyK4EigxUI+dvtxnf90mV9Sqq8F
 wcjK3k2ldW+9gz5RL8GsoW/qoDcWLS6w6xenBjcyHD+zFLjhcEWO61ayygW6QN718bxCbBU98
 CG0rR+MsMBTvQSypq9M0/rNClxi0D1jovV9wa3O4B1vAV74TMudIT042zHg4DHuWV82zq7Kq/
 AaVfxdlNAxD4Ivqv85MxXn43ZY1B44miK9rWO4yL88DOmB7ll+feNOVB1u52+fb/Pm5UXRvKZ
 y/Q5fz7HMIK8FdtMQVWY68CQkkZa+C40sH5K7B37sFJYRFWZFc1G58enQkJkmmBooHpXng244
 zOynVVDh/h3ZjORSv1/z5iyzLrxd1daKF+VogScRuCgHRsL0NIaJDlRnZ57uXkzp8RDQpoa86
 zrZ3clgSXUinu2stLwFTmmdC0yJj4VmxxOZ6qoMpKOarox+4dNextW8T9uY40wgiNs0fUkfH6
 SjDKNHZnqDNApfsGvkd3o8s68+BASkexGfH+/Hm3z70DmH6UaTDW1g0jy1XHpN9RhFQdaWLaK
 YVLd50XcskWLiF+ln4yAkU7lAttHF96qWU61y0DZ7GbpZANwm4WPOeZSWiI7B/abeVCeRQdRN
 pRHlGfUtKpdepqG3f1dImBKdxqYi08aGsaj4=
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

On 2/25/26 03:01, Johannes Krottmayer wrote:
> Add build steps for building U-Boot in secure state with
> TF-A and OP-TEE. It includes the full steps for building
> OP-TEE and TF-A to use with U-Boot. Also a short
> description how to invoke QEMU with enabled EL3 and EL2.
> EL3 (machine option secure=3Don) is required to run TF-A.
>=20
> Signed-off-by: Johannes Krottmayer <krotti83@proton.me>
> Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
> Cc: Tom Rini <trini@konsulko.com>


Hello Johannes,

Thank you for your suggestion to enhance the documentation.

Unfortunately your mail does not contain a valid patch.

Applying: doc: emulation: qemu-arm: add secure state steps
error: corrupt patch at line 53
Patch failed at 0001 doc: emulation: qemu-arm: add secure state step

Please, use git format-patch and resend the patch with git-email.

Best regards

Heinrich

> ---
>   doc/board/emulation/qemu-arm.rst | 86 ++++++++++++++++++++++++++++++--
>   1 file changed, 82 insertions(+), 4 deletions(-)
>=20
> diff --git a/doc/board/emulation/qemu-arm.rst b/doc/board/emulation/qemu=
-arm.rst
> index 1c91c7f3ac6..017dbab3831 100644
> --- a/doc/board/emulation/qemu-arm.rst
> +++ b/doc/board/emulation/qemu-arm.rst
> @@ -24,8 +24,76 @@ Additionally, a number of optional peripherals can be=
 added to the PCI bus.
>   See :doc:`../../develop/devicetree/dt_qemu` for information on how to =
see
>   the devicetree actually generated by QEMU.
>  =20
> -Building U-Boot
> -------
> ---------
> +Building (secure)
> +-----------------
> +
> +U-Boot
> +^^^^^^
> +
> +- For AArch64::
> +
> +    make qemu_arm64_defconfig
> +    make
> +
> +On successful build 'u-boot.bin' should be created. It's necessary in t=
he following steps
> +(building TF-A).
> +
> +OT-TEE
> +^^^^^^
> +
> +- For AArch64::
> +
> +    git clone https://github.com/OP-TEE/optee_os.git
> +    cd optee_os
> +    export CROSS_COMPILE64=3Daarch64-none-elf-
> +    export CROSS_COMPILE32=3Darm-none-eabi-
> +    make PLATFORM=3Dvexpress-qemu_armv8a CFG_TRANSFER_LIST=3Dy CFG_MAP_=
EXT_DT_SECURE=3Dy
> +
> +At least OP-TEE v4.9.0 for AArch64 needs both compiler (64-Bit and 32-B=
it edition) for a
> +successful build. On a successful build following files should be creat=
ed under the directory
> +'out/arm-plat-vexpress/core' from OP-TEE::
> +
> +    optee_os/out/arm-plat-vexpress/core/tee-header_v2.bin
> +    optee_os/out/arm-plat-vexpress/core/tee-pageable_v2.bin
> +    optee_os/out/arm-plat-vexpress/core/tee-pager_v2.bin
> +
> +TF-A
> +^^^^
> +
> +- For AArch64
> ::
> +
> +    git clone https://github.com/ARM-software/arm-trusted-firmware.git
> +    cd arm-trusted-firmware
> +    git submodule update --init
> +    export CROSS_COMPILE=3Daarch64-none-elf-
> +    export BL32=3Dpath/to/tee-header_v2.bin
> +    export BL32_EXTRA1=3Dpath/to/tee-pager_v2.bin
> +    export BL32_EXTRA2=3Dpath/to/tee-pageable_v2.bin
> +    export BL33=3Dpath/to/u-boot.bin
> +    make PLAT=3Dqemu BL32_RAM_LOCATION=3Dtdram SPD=3Dopteed TRANSFER_LI=
ST=3D1 all fip
> +
> +On successful build the following files should be created under the dir=
ectory
> +'build/qemu/release' from TF-A::
> +
> +    arm-trusted-firmware/build/qemu/release/bl1.bin
> +    arm-trusted-firmware/build/qemu/release/fip.bin
> +
> +The following file is at least created with TF-A v2.14.0 and can direct=
ly passed
> +with the '-bios' option to QEMU::
> +
> +    arm-trusted-firmware/build/qemu/release/qemu_fw.bios
> +
> +If the single file doesn't exists 'bl1.bin' and 'fip.bin' can be concat=
enated with the
> +command 'dd' alternatively::
> +
> +    dd
> if=3Dbl1.bin of=3Dflash.bin bs=3D4096 conv=3Dnotrunc
> +    dd if=3Dfip.bin of=3Dflash.bin seek=3D64 bs=3D4096 conv=3Dnotrunc
> +
> +Building (none-secure)
> +----------------------
> +
> +U-Boot
> +^^^^^^
>   Set the CROSS_COMPILE environment variable as usual, and run:
>  =20
>   - For ARM::
> @@ -38,8 +106,18 @@ Set the CROSS_COMPILE environment variable as usual,=
 and run:
>       make qemu_arm64_defconfig
>       make
>  =20
> -Running U-Boot
> ---------------
> +Running U-Boot (secure)
> +-----------------------
> +
> +- For AArch64::
> +
> +    qemu-system-aarch64 -machine virt,secure=3Don,virtualization=3Don \
> +    -nographic -cpu cortex-a57 -bios qemu_fw.bios
> +
> +For additional QEMU command description see running U-Boot in none-secu=
re state.
> +
> +Running U-Boot (none-secure)
> +----------------------------
>   The minimal QEMU command line to get U-Boot up and running is:
>  =20
>   - For ARM::

