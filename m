Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B247C021B3
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 09:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E9FD80079;
	Mon, 24 Feb 2025 10:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gSaBJ7B2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D803280C77; Mon, 24 Feb 2025 10:46:20 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAE4F80017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 10:46:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740390376; x=1740995176; i=xypron.glpk@gmx.de;
 bh=ONgSjBn/ysCZ/vQ8LzVpIkcyXWKZllFL7oiRNCneAx4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gSaBJ7B2Edd1qG3ZAre4CdmUqQEsHgXScCj/SwZr18EQ8uvN4XKJkrfXyzqMYddF
 okpp24UeUNhayXZZIpkMfeuK3E7kk3SYZ+zuDlNZXF+YPfpgbNZVxS2AowxU7c4gq
 u3FzIUFGTgsRTQAiLlQIIy+dDF8YtCPP7iOqtY9vmPJEMreD1PXQf3NbvkXrSHheU
 EjgdDlDYm0HKzwgrYcVgsqb09JfCvbXcYawinumFiZXcPg5amRdvqmB6488X3S48G
 R4gNIgSN7SiN9dKK9RceQUKZJhsVk4xkmmA2CaKgFKTk0ykEz5E2VDfYkfWQ+Yf+v
 iJ/x4QBGmVd7yXo7UQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIx3C-1u2VSE2sV0-00XoC9; Mon, 24
 Feb 2025 10:46:16 +0100
Message-ID: <1b5011c8-665f-4d21-84e7-990475720251@gmx.de>
Date: Mon, 24 Feb 2025 10:46:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/17] scripts/Makefile.lib: efi: Preserve the .dynstr
 section as well
To: Sam Edwards <cfsworks@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-18-CFSworks@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250224055524.1334929-18-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CHYhx4Wku1WCxqvnsBrg01EqZlqBwEZnVyq+OeOQTcVYoNtbqfN
 rspt65FUEO2+6zW4feEq7zJvA5j6DXfwMZolTMZM7YUkhsaanzv/1lmObb4c6QVmkEjeQjh
 RTpT8kvJUsO0msWLBE3xFGdJAvmFhG0fbxMXm4awFjGjSlQv65Sccqsxaafkib0bwLWZALJ
 Q4fdSZBUVL0NsTf/v9Cag==
UI-OutboundReport: notjunk:1;M01:P0:4SSKdlhFj6c=;3yJj+yP982EWt47PbsgdQHcapGy
 qhm8c+gr6QjuZKoZfCOhIWUYVkk90cHwS9ztAgEKWOxhjtJVOy6LfF5j+MbwDYvvhFZKGSN0Z
 HyjSKfT093kcgFJUH+ub64iwj5CruSRNbYc84QA6o2ECOXhbRtTN/j9ngEnPZ9HSmWoKC4TgA
 iW1gSN1CSq0qJwqtuETVjCvQYCmzrUiEryOJieHoJTCezHzYhySlg3Wy3O902/9nPX3/9K9p+
 b1kt4cVxc2zbHimEkHL2nrK+u9yvyvutn3HuAE9+VZ6ss1vI1+D2oPWU/BjC6C2E1PCvjc6u8
 8Z4DRZq+oWlmJ+uz2a+CbCDJE07cxS1ZYaCLf5y/h5Wf4jgzSRYTqQTjsETFgcNtu1OjqxWCb
 2m8DGWrOmWZxCyr4yVTpeZx2IBo0FdaVd76vjfqgSSNRCPW+w2b+jlWOHjBCZ7LWfI6CEaO/o
 t5/way/oB11BdpZvGWAiT/dgQGg/JPQDwDvBSxwgY7dIZatKgLqu3GYZIf+6yJQOAWE6km0u8
 AXDUyCEr+lq8mXNVQM1GOF4u/Y9S1n+oYY1yjImfiMd7Z8uaEkH/OSzfvH076LGvys2ptvcOa
 BlIyLWwaoUDq3SYcQzOOX4bqx6r5qSRVvi4CQ1HcxPwTsJCcXK+YohvITR+7iWF1EeZ59BGnm
 YHGV2M/W8bg3EAhSL7f8ZCCHjBy+xHQeDmVFND/Rh2fqdmDuAUmr082jUK0cX0h8u1MZKE9Cn
 YukrJZbdrxg2nrlzPn3z9VwPDBwbpNcwNVHeo61imFpwVgkWvgNAhXGbrAL2zwQTPXTcmLWWu
 1z9geo4s9RbgCGiJALQyZBVENnp5o9P0mU9b0WpuZiJrF/F73uT9eLErJFdttawQGyG61OtF5
 //iUrCJFcV5uZasGgaQ9f1321qVEI/P2OgAkczrygOxEm4qV6s9VP2NUmSvPqoMwhjtL+gnJ8
 pbl913DJZQsnnZ8P+h5p51IMUcbS+Pc24E62PR2uU2Pl7rJGvnlEJIX6A/W36bQA8m7YECfco
 Lj+4I/Dx7kbDRTW6uJIHeQjH3hBZQuHXIKWzqeBMDbROTbZP4ybiDtZQgsPdaoDYNE6x3h0+Q
 01MHQxJP7CeR9glUMuL97ZyKJrzfTBBXqJ0reBKwWoziOV0HkaeEF0X64Xt3/kKwkM8x4DFzc
 h3XMY9sPuVGuozIxCm+Wp8CJFD11k9MbA3FiTsk2bSPz4RoP5sMQayS3kN4U/Z2fwSiWWNduK
 CRoUzQ2PypcXyhYoacRXRSMaVmeT6qXagGRj52rtQuW/Nm4Lv5Eiz4pXjjb570CL8N7QRB5Vj
 FqDJ0imUBIgJR51s9BCzL2yfM66zBnNW63+CVPlQkosnsnnHpHpnzwi7u0Aq0e0DiRDz5zq+g
 TxZKrifEIWoup8x5QJjxQ9Xi4mH8qMc+imSYbmZ0XWbubClEHj9nerUr1C
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

On 2/24/25 06:55, Sam Edwards wrote:
> This section is required by .dynamic and llvm-objcopy will exit with a
> fatal error if it is not also preserved in the output.
>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>   scripts/Makefile.lib | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 18993435eae..275c308154b 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -513,8 +513,8 @@ $(obj)/%_efi.S: $(obj)/%.efi
>   	$(call cmd,S_efi)
>
>   quiet_cmd_efi_objcopy =3D OBJCOPY $@
> -cmd_efi_objcopy =3D $(OBJCOPY) -j .header -j .text -j .sdata -j .data -=
j \
> -		.dynamic -j .dynsym  -j .rel* -j .rela* -j .reloc \
> +cmd_efi_objcopy =3D $(OBJCOPY) -j .header -j .text -j .sdata -j .data \
> +		-j .dynamic -j .dynstr  -j .dynsym -j .rel* -j .reloc \
>   		$(if $(EFI_TARGET),$(EFI_TARGET),-O binary) $^ $@
>
>   $(obj)/%.efi: $(obj)/%_efi.so

I see sections .dynsym and .dynstr in intermediate *.so files but no
.dynamic section.

Why would we need a .dynamic section for a static EFI application?

Best regards

Heinrich


