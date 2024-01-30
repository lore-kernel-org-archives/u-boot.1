Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43EFC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 08:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1129A87729;
	Tue, 30 Jan 2024 09:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Ay+hE9tf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0C29877B0; Tue, 30 Jan 2024 09:15:06 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80408876E4
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 09:15:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706602502; x=1707207302; i=xypron.glpk@gmx.de;
 bh=T/5u7okB9t1eUmWKSsJQWPFpbyte74+w19kFLzS8M0Q=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
 In-Reply-To;
 b=Ay+hE9tf+uugJx5l9op8Sly/mKvup6HdppjLtV5zWs1BxHOOgjZcLUkunKwy+ovc
 J+ZKcc+VpJJa4oY+8eOgLBhn11CJq1/kZVSpPdUdgksGbjy3Fnx9lPvgPz3LeUCCg
 pxXquAHEflyBHInuyJfGDO+FZwiCA6HJYbU8QsK8Wq2sba5vRrfq/7tyS/Sf+BVnE
 CdIItD5t9BMDC4/V7bm7GCeU9f1iti18aJg0e5DUP9TIpZit7HmTcKzpwRGT805eY
 RbM8uprg6y8bGbqJ7Hk16UP9QgCAueYVvEiaGiJkD+G95KmxGnm1UoFPfGzgtooix
 ae6R15M+ZJtJOnhDIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWzk3-1rXEPE3Ioj-00XHIJ; Tue, 30
 Jan 2024 09:15:01 +0100
Message-ID: <ebc55ceb-0cae-422f-acaf-5f5439f29899@gmx.de>
Date: Tue, 30 Jan 2024 09:14:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
References: <20240129235537.GO1152441@bill-the-cat>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240129235537.GO1152441@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XgFTmT/BNTDhgHjekNA4vo8t+YF+H+DVbBBM3K3O6Zepw4O9kR6
 SOGU5dDVk6qBxJAEh5oLohXQhkWyW+wW98LvcGTL6VcWJkjerv0Gv1w8hq2U4vOHnN/UAq5
 17kXphz1uZxz0xksexxw6I9Ip1WET53eFI6YCfFxysDYxEC4vSb1mMBdKKhZSvexxkpWw8V
 eP7OHKx6KCyeu6tejM2lQ==
UI-OutboundReport: notjunk:1;M01:P0:irSnLzQ91NM=;1tofRNt6UIFDJDarh1iyiDzWCEB
 KkI7ZH/RbD5rX1fSUDYJlI1GUgZiIM/g8Xm4xxDSto8Uksi9R4W7ouX6Vm2H2D+7/7DGv/WmL
 xtpK1OeA8fZTI5B7M0PVx7331w+VTYsv0hDjAZGT7W6yLNbVH5H1IbhvEHY51RlMkjXzqcRiR
 5LsVIMNe1SV8pY+7sJuJvyKc5SD2jsawMlSxNjcIL+z3R2X3epIGWVet5F2tD7JchLEYUgTol
 DIogi/0Y0Gu/32L6kxwwnSyZFPx5ULlrU1u67ui3up4q5uG6wDCYKFS2PniVxpqkcorW87nr3
 ky6lFbWt+m8t4AuHw3Dz0/7duCx6/sRmabKw4Ir3PWUBewg3i6DBq1APBkm6PztA5x/cIaand
 zStAc1qrDW4mqSXb8P29nh8mr86LsFXFcR9Uw20WkhcCPr3eTBbnwIO888slSKJ36T7Z4Bohy
 aXcbqsqFtPJ+4pQvuXf2OprheldgfdjO18VA2emHxRq9gi3mxsMWF1IhkV2/0ow81pJKYATFY
 kvluyWJvCJSjJwnICi6VW8VdEuvs4JOdSKGEuhwjy9Au19Ds/0N6T4C1oHr2l/vtY+qLeJHvB
 E4D9F3lLt6jJ1EBOKXfIIZVfnxxNvNNQ7xADEgOZqd/XHB7TZXtR5O+lszl0SoMs3WyMk4yB5
 9e6r9JyF6f7Ne0GnUVuQSW0HQ6QzldpLyCT0im1aeMQB2izjMnjGcDRJbN6VS2CeSnAZlrk2d
 K8e/m3D3BXWyD30TwJMDJbKYL7Nc6uPDlDjcJnLUCQgKSY8jxUN7ubmRzjTBLv8Iv/ij/CC3N
 e6LwliNUR9yNrLargqqnu6gQgWZt8mnOkhKD+qKLvQw/JfdP7XbY0mygWSvNOO/yep0clzBhG
 +2SYy5cE4dsL5saen7RIXvZJK82AkO3h9noGo3o1ZqB8tvcZn/CfECLccI8CwBXjlKqmhlKv4
 nQF6NfqJJ9GWY9O1D7bZq9VjTKk=
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

On 1/30/24 00:55, Tom Rini wrote:
> Here's the latest report.
>
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Jan 29, 2024 at 6:51=E2=80=AFPM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to Das
> U-Boot found with Coverity Scan.
>
> 1 new defect(s) introduced to Das U-Boot found with Coverity Scan.
> 1 defect(s), reported by Coverity Scan earlier, were marked fixed in
> the recent build analyzed by Coverity Scan.
>
> New defect(s) Reported-by: Coverity Scan
> Showing 1 of 1 defect(s)
>
>
> ** CID 480240:  Insecure data handling  (TAINTED_SCALAR)
> /cmd/efidebug.c: 192 in do_efi_capsule_esrt()
>
>
> ________________________________________________________________________=
________________________________
> *** CID 480240:  Insecure data handling  (TAINTED_SCALAR)
> /cmd/efidebug.c: 192 in do_efi_capsule_esrt()
> 186
> 187             printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n=
");
> 188             printf("ESRT: fw_resource_count=3D%d\n", esrt->fw_resour=
ce_count);
> 189             printf("ESRT: fw_resource_count_max=3D%d\n",
> esrt->fw_resource_count_max);
> 190             printf("ESRT: fw_resource_version=3D%lld\n",
> esrt->fw_resource_version);
> 191
>>>>      CID 480240:  Insecure data handling  (TAINTED_SCALAR)
>>>>      Using tainted variable "esrt->fw_resource_count" as a loop bound=
ary.
> 192             for (int idx =3D 0; idx < esrt->fw_resource_count; idx++=
) {
> 193                     printf("[entry
> %d]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D\n", idx);
> 194                     printf("ESRT: fw_class=3D%pUL\n",
> &esrt->entries[idx].fw_class);
> 195                     printf("ESRT: fw_type=3D%s\n",
> EFI_FW_TYPE_STR_GET(esrt->entries[idx].fw_type));
> 196                     printf("ESRT: fw_version=3D%d\n",
> esrt->entries[idx].fw_version);
> 197                     printf("ESRT: lowest_supported_fw_version=3D%d\n=
",
>
> ----- End forwarded message -----
>

Coverity sees any conversion from void * as a hint to tainted data. The
ESRT might be manipulated by some EFI app but we want to display it. So
I marked this Coverity issue as intentional.

Best regards

Heinrich
