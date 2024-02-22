Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EC2C48BEB
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 12:36:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8773688095;
	Thu, 22 Feb 2024 13:36:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="G6rWzSDb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F4E387E4F; Thu, 22 Feb 2024 13:36:56 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8455588095
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 13:36:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1708605407; x=1709210207; i=xypron.glpk@gmx.de;
 bh=Fqr9p/DfCIflS4ttUG6puLhMvFAA4nro7fIGAFgNFj4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=G6rWzSDbDDjTPD7EgEv0Aousd+CMdFtro/oCJmyoJEqhhUnHVMdrkczR8Rk8P0Oo
 +fDyM6wE2xo3jfMeCdyoCvJ13k1HRvuitug5+9sY8DYvqfe43DdYEGF53ybszfk1k
 ZEnmkoSpb9tT+hImvMdS8fQ0T0LQuWrEFfDhfTSbpmLMuU2jJxA+WqT4ByQiWK1VJ
 OAqBuJIT0aYtMuALBofinalTVpjy3bmoh7iJ2L/OQG5TTfn3VBFZRY4fkh95syYq8
 Z5eWa2R9ejbWPCkC7MCCVIMq+i7JaYyLlfEcFuUDNV8APzvQclHUqP+KA/z7Vgof+
 PzrBtDAOgkAftKQVuQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQT9-1qlA5K2n4P-00sOXW; Thu, 22
 Feb 2024 13:36:47 +0100
Message-ID: <d6ce764a-e04d-46d4-bb28-84323f250eaf@gmx.de>
Date: Thu, 22 Feb 2024 13:36:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: riscv: supports_extension() broken for long isa strings
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20240221-daycare-reliably-8ec86f95fe71@spud>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240221-daycare-reliably-8ec86f95fe71@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FodkpYhB+9OA1fMgiSzvPPZ29YufgZmPiSbrh59mizs/OsJldv+
 2hT2/r/WBkeDA9OnM8Sj3IF/IwLG9gUGFNKJbdAPo63YubRnBt1Fi4NeerJhYLztNp5NnVc
 YCYrq4/H8IIbG9u7yKwbltmD3cg6Wh8R4aEQGmA8bNO4MbrtF30IGBPmVr6RKv5dHWFZX9t
 H+Ky6wVpiCCvQ3X/x0bhg==
UI-OutboundReport: notjunk:1;M01:P0:TOujo1KzFQY=;+LRUHi2rZdXWS7WyEuKoXhDDv3F
 hBwqzigsf3LZvqWRq8fLECHs2e8YS8iZTm+Q41LOSJ5PT/kc7xaXs+3E/7lttPCUWDVKOftUK
 QkY6zMe2O7gEmmETZpcbKvz2z3s5n3v9Pks8Pan56JpTJ8t1D+zzTYzAlTOBjnVij/mQBVxSp
 aWnMfY8UUDhLMVUbytO6jE3JBNvNhPsJtDxfR0bEHu/631L/ig2pAj+Mt557zE8eTTkDrjL1h
 jKtOlK2ZlTLMaA1+zjbTt6NcIR+KIZwRd5kubDMXopVlz6PuRPba51rNxamlB5GgIx08A3TQH
 byxT47QcIu0r8zcEjVdGRbR4v38kgEzfctkTZNpU5uJ22QMgH4jlFoTIcrQmYXPcp0r8EU4n2
 0Q1XwBwhJMp46x7Yzkp/7+DvjyFxAJI/l7IUMF4ezidyg/4v6bAD3kAN2bhjT1c3xkP6ktEBn
 ZDHeL69XG2UBJ+BBGWevZxLB0u5dC3JkJR5dJEe37z8wcbAR1esmG11mV4E9WmFQxbhSIDQm5
 hNzR2t13/6CTT8wKPpCh6qlOdBi841f5YWratykS5wUKdnUshfxJo8z4gtJsfA8eSs4ZCrkLV
 I+y9dr+FkDPtKFXwnSZ/m3lJ+0JEpytSMdM6VYhO4Z+RV5QEdYNg4hQNci33TBHPRfJ9HtIEW
 77i/rctpt3dove4qWtX5D+Rfq1O2H+FFEtm9bRys1zAz4hj6cJ2fZALCp/YA7wYhwmDczZ4kl
 Dp991aaEDS3UyKtIDwbwMAdhTspBxEPItTG/FrGbT09V2kQkDa6Wl0ZWkGunUK+ydkt1+e9vO
 hcAPFotF85aA3TyxywjHEXZ96cpBxJLqR8OkEbhKs90Bw=
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

On 21.02.24 18:59, Conor Dooley wrote:
> Yo,
>
> I mentioned this last night to Heinrich on IRC, supports_extension() is
> broken for ISA strings longer than 32 characters. M-Mode U-Boot doesn't
> parse a devicetree, so this doesn't apply there, but for S-mode
> supports_extension() looks like:
>
> static inline bool supports_extension(char ext)
> {
>
> 	struct udevice *dev;
> 	char desc[32];
> 	int i;
>
> 	uclass_find_first_device(UCLASS_CPU, &dev);
> 	if (!dev) {
> 		debug("unable to find the RISC-V cpu device\n");
> 		return false;
> 	}
> 	if (!cpu_get_desc(dev, desc, sizeof(desc))) {
> 		/*
> 		 * skip the first 4 characters (rv32|rv64) and
> 		 * check until underscore
> 		 */
> 		for (i =3D 4; i < sizeof(desc); i++) {
> 			if (desc[i] =3D=3D '_' || desc[i] =3D=3D '\0')
> 				break;
> 			if (desc[i] =3D=3D ext)
> 				return true;
> 		}
> 	}
>
> 	return false;
> }
>
> cpu_get_desc is implemented by riscv_cpu_get_desc():
> static int riscv_cpu_get_desc(const struct udevice *dev, char *buf, int =
size)

Thanks Conor for reporting the issue. We should change all cpu_get_desc
implementations to:

int riscv_cpu_get_desc(const struct udevice *dev, char *buf, size_t *size)
{
	size_t old_size =3D *size;

	*size =3D snprintf(buf, *size, "%s", info) + 1;
	if (*size > old_size)
		return -ENOSPC;
	return 0;
}

With this change

size =3D 0;
cpu_get_desc(dev, desc, &size);

can be used to get the size of the information before allocating a buffer.

desc =3D malloc(size);
cpu_get_desc(dev, desc, size);

Best regards

Heinrich

> {
> 	const char *isa;
>
> 	isa =3D dev_read_string(dev, "riscv,isa");
> 	if (size < (strlen(isa) + 1))
> 		return -ENOSPC;
>
> 	strcpy(buf, isa);
>
> 	return 0;
> }
>
> On most extant systems, riscv,isa is a pretty short string - between 10
> and 20 characters. In QEMU's default virt machine however, we get:
> riscv,isa =3D "rv64imafdch_zicbom_zicbop_zicboz_zicntr_zicsr_zifencei_zi=
hintntl_zihintpause_zihpm_zawrs_zfa_zca_zcd_zba_zbb_zbc_zbs_sstc_svadu";
>
> Since desc can only contain 32 elements, the size < strlen() test fails
> and cpu_get_desc() returns an error and supports_extension() in turn
> returns false.
>
> Currently, in S-Mode, there's only two extensions that U-Boot ever looks
> for and they lie inside the single letter section, so 32 charcters would
> be sufficiently sized, if cpu_get_desc() supported undersized buffers.
>
> I came across this while adding support for a different way of detecting
> ISA extensions, rather than running into an actual problem because U-Boo=
t
> seems not to actually make use of supports_extension() other than enabli=
ng
> an FPU that there seem to be no users of in U-Boot at present. I also
> assume that using U-Boot in QEMU is somewhat of a rare case, given with
> virt you can boot an OS kernel directly. That'd make the impact of this
> problem pretty low, given I just happened to notice that in my test
> environment no extensions were being detected and the operation of
> U-Boot seemed unaffected.
>
> I'm mostly just wondering if, given the impact seems to be rather low,
> if I should "bother" making a minimal fix for this that would be
> applied to master (or backported? not 100% sure of the release process
> for U-Boot), or if I can just fix it in passing while making "riscv,isa"
> optional?
>
> A minimal fix would look something like the following:
>
> diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
> index 8445c5823e..df508ac4a1 100644
> --- a/arch/riscv/cpu/cpu.c
> +++ b/arch/riscv/cpu/cpu.c
> @@ -39,7 +39,6 @@ static inline bool supports_extension(char ext)
>   	return csr_read(CSR_MISA) & (1 << (ext - 'a'));
>   #elif CONFIG_CPU
>   	struct udevice *dev;
> -	char desc[32];
>   	int i;
>
>   	uclass_find_first_device(UCLASS_CPU, &dev);
> @@ -47,15 +46,16 @@ static inline bool supports_extension(char ext)
>   		debug("unable to find the RISC-V cpu device\n");
>   		return false;
>   	}
> -	if (!cpu_get_desc(dev, desc, sizeof(desc))) {
> +	const char *isa =3D dev_read_string(dev, "riscv,isa");
> +	if (isa) {
>   		/*
>   		 * skip the first 4 characters (rv32|rv64) and
>   		 * check until underscore
>   		 */
> -		for (i =3D 4; i < sizeof(desc); i++) {
> -			if (desc[i] =3D=3D '_' || desc[i] =3D=3D '\0')
> +		for (i =3D 4; i < strlen(isa); i++) {
> +			if (isa[i] =3D=3D '_' || isa[i] =3D=3D '\0')
>   				break;
> -			if (desc[i] =3D=3D ext)
> +			if (isa[i] =3D=3D ext)
>   				return true;
>   		}
>   	}
>
> Cheers,
> Conor.

