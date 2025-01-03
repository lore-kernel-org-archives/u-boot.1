Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76754E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 15:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A732B80295;
	Fri,  3 Jan 2025 16:10:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="h6GI+78E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4ED88035E; Fri,  3 Jan 2025 16:10:05 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EFB5801A0
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 16:10:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735917003; x=1736521803; i=xypron.glpk@gmx.de;
 bh=EmcooEkbk/S+uQqZtjbHtGTZMCE4h7M97ij7i8dlVLw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=h6GI+78Es9PRSyIFu25XLl+2gjcHPbc6kw7rJYeMmZ05ShgdvJQqNqJLgZXd7UpD
 Svz9XCFPjk1ZzvDnew1d4Mfo2yzxhyCtYW2x0zNKlgg3cMSKXX5VBIr9jqgPIya8+
 MD38b3EvzpyltcCM+ciDZyZf6d3UlenDAMmzs8Zd04x//HsfxXg68tLdW9/C+Uuhr
 582EjiTN+ZCfRA0H58AQ2KKPasTO7rroHrtz1hkdQhTLfn7xSinEnM47cudrH2il3
 uwjTmHSQDqn2Nsb0ejsZ/wPoLFkoH9QJz8Id0egFo27aIM47Vv73YIlQmoNoGEidJ
 gIUyzvOBdsfO2IPJ7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.106] ([46.114.109.94]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lc9-1tSuEL3D7r-00033x; Fri, 03
 Jan 2025 16:10:02 +0100
Message-ID: <6014d961-724a-4337-a2b4-e9ac43f11ae2@gmx.de>
Date: Fri, 3 Jan 2025 16:10:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/67] x86: Align the SMBIOS table to a 4K boundary
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250101221003.1944600-1-sjg@chromium.org>
 <20250101221003.1944600-34-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250101221003.1944600-34-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oqv4nFRbjcCBfha9i2pmzWWxs9N2yVpzzJuRpUrL8l/H9xy4PMh
 hqb39jb1pgmDV6B57DzFdXLVlc+nMlRkiwsLLSD8W1g16CVqULePeAKmux5UpKyZtlQK5G3
 UmIoAfW2IfFbRcZptHG3ffOwKgFy41tTcYHnHdtgiuXW0CShl1BZMzPFVhoKnvc5hscFAdW
 Y4UWCu34pBaHvBSuTgImw==
UI-OutboundReport: notjunk:1;M01:P0:7JBwTNjKQXg=;yZ4s+RfhfPwrFa1pGez6qd3+6/k
 ZUgHUf9V/ERVz1wz4YMDG2Ll5/Sx2WRaAdgKvdKcooq2ySHBWJDzdRAVSBJl/XNRBeynGpnD1
 81J8eZER9oSmyuxQo9d6EziJXLIDPxRvAT83+FybO5IP/hRwiZf2S+KKpDPh9zfxE8Ud2wtWs
 e3D8qtcMLWkx2y6pnTzjIe5CWJODNobAc1W4PPEWaaijgtzU6Ll5WxEreJ0YdV3NCNjv67mni
 g07bDfGV8SU1/WEM6pizZnGdX43+N2VCT3DtnwbzsNzsSloUk/TPeUBZj8q1f7AdEEyZmZChD
 hqm58ss/d0PQ7sZwtZ1h2eN5FjCY2/1r/40e9YCOF2DYEomCwTjU2mkn8WjP516kAcEzDpVt3
 V2rLAXRZwo7BDVd+DpgzHkMdpNBrp5ZOa5OFzfBbTp88ARgUlm1sjzlANZosiVTYxyEqhGkBo
 vv5bmL4KLAHai7h6XcQHnZZZC7IsOJZ3KZu2k8N48iw5Kgzlx9uNGHC+iy++lar02XQcEQyF6
 IGCt4s8fy4BcD89vs5PK629U6+jHEvYvtOvLi4oegHDsEsoMzv2C8hVBKMTqICYez4jzy5/W5
 VFSzu49CzGYWFGt8OH2Lf1hKUnOSX4FuPTJNHcqc6k3J3ka/2VOPEAI1LkJxB9P/TILpncqwu
 H3m9jOSINEa9/M+3kFLzdr0bpUDb4fT49UpE6a8ldmKHDurbIokacuTwj4Wk8kSIZQfgciAO/
 gowTMjcdGkFUutkaJQurbjnox7SwCainMMvhuOvHVXLYn8TaQLdUuYQ2MIn6WuMVhPkJ+gnXr
 UgYjMpaMLT9zDRdzY/UiP/bhmE0Mzn5Ab+O8obkA3HHqGwXFzwzpJScdHFL83DEDT/0cxd7aQ
 2LZo2zsXEhtQWREb+U1We6x73Ul6tMVw8ahFkYZXcxbcXhZKEo9k4pQliyVsn7JjWrT3v7+HF
 wfxw3YtxU33mwCkvYUxbti2XVRz9n5R03c0CfA0Rs5sXCcKhkr8rqww3N+qlvB3oTyE5n58N4
 9EPWKDr3LzZq2qAUW+d2Is2oZOiHOogB0gmjrSlZR+omTCBeUKNs3S8LYlUfF10rUKFhneIAS
 pQ7WMGO13QHf1rZoZ58/LqBu3GTjY1
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

On 01.01.25 23:09, Simon Glass wrote:
> This isn't strictly needed, but with UPL we use the reserved-memory
> nodes to indicate where the SMBIOS table is. Tianocore requires 4KB

Nits:

%s/4KB/4 KiB/

Cf. https://physics.nist.gov/cuu/Units/binary.html

> alignment on these regions, so it is easier to adjust the alignment
> to match.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   arch/x86/lib/tables.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
> index 5fc7dc75377..3978945a5ad 100644
> --- a/arch/x86/lib/tables.c
> +++ b/arch/x86/lib/tables.c
> @@ -16,6 +16,7 @@
>   #include <asm/tables.h>
>   #include <asm/coreboot_tables.h>
>   #include <linux/log2.h>
> +#include <linux/sizes.h>
>
>   DECLARE_GLOBAL_DATA_PTR;
>
> @@ -62,7 +63,11 @@ static struct table_info table_list[] =3D {
>   	{ "acpi", write_acpi_tables, BLOBLISTT_ACPI_TABLES, 0x10000, 0x1000},
>   #endif
>   #ifdef CONFIG_GENERATE_SMBIOS_TABLE
> -	{ "smbios", write_smbios_table, BLOBLISTT_SMBIOS_TABLES, 0x1000, 0x100=
},
> +	/*
> +	 * align this to a 4KB boundary, since UPL adds a reserved-memory node
> +	 * for it
> +	 */
> +	{ "smbios", write_smbios_table, BLOBLISTT_SMBIOS_TABLES, SZ_4K, 0x1000=
},

Please, avoid using once SZ_4K and once 0x1000 when expressing the same
number.

If you want to go with SZ_4K, please, also change the ACPI table entry
to use SZ_16K and SZ_4K to be consistent.

Best regards

Heinrich

>   #endif
>   };
>

