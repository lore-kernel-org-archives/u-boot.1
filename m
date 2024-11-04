Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B312FD111AE
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 21:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20ADE88D4A;
	Mon,  4 Nov 2024 22:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="fOEDsa2j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E234A87F7D; Mon,  4 Nov 2024 22:42:30 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01F6A87F7D
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 22:42:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730756546; x=1731361346; i=xypron.glpk@gmx.de;
 bh=wBgH6D98dynnEQTY8CmforNdhsEM24plUTeL9HgpCm0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=fOEDsa2jD5grjvxjBQwqRtHSff9HAWA2TVNwNaRCmnf4i9SV0jG4rV+T979mM8un
 hbQfT75tPhapcsiCqQh17UgIqM5EPWEQh+YLQA+ACuQCI8rsMUAzXbbr73X8XBx/l
 qMooEOgj4IGhEneD/xNz/STEyz5X7/wG8Bk9HFOrzzbwaVcRTRIdTFtHSZuFukWDG
 UjZoIWDep3LI7jy3k+dF4ShwXwRxx7JFhZP/SuUSmmNZtWh085c4SSJ3FIKTIdSse
 3q17mSbY3JB7YlzpnTpW9ow+wuOwQnmNUCWYqVz9/5qOOOAMPLV7TnYszff7bXxDO
 SIVeSHFU9z1UPkSlzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.108.63]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mbir8-1tgqZ22eOk-00lm3S; Mon, 04
 Nov 2024 22:42:26 +0100
Message-ID: <113aa432-79b7-4920-9b76-cb3543186efd@gmx.de>
Date: Mon, 4 Nov 2024 22:42:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/19] bootmeth_efi: Check the filename-allocation in
 the network path
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241104175110.1048449-1-sjg@chromium.org>
 <20241104175110.1048449-12-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241104175110.1048449-12-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jfWJU+2Sm6W3kGOUJC+NzEpXiZhHPMoZLl2qAbXbVzZK3IS0sCr
 rg3HvpczRkx1SskL9LRS93XjboBXJa6XnRGtdiTYiZJvg7WHTQSNiW7AajRmN1dZZKk+X13
 g/IAv6xvSRpWD0jKe/GR9DXpRaVKTWfD21Nn+UbnhNr+qg17hvW90Y012kqHgbhF5yUDLTy
 mi1QvoMA1P5vZeiBxUmhQ==
UI-OutboundReport: notjunk:1;M01:P0:FQ8nCZcSzxc=;JYaTy43Pbh/k/FtE2bod3lmaoSm
 9LOErUyec5125JfR+ZbiAMudFAkQJ7lOgncehohXfqPJ4YFsDjvwePkWLDN+SHs8eMVxORjlZ
 S+Msh2025BhCXopmnrBqlmftpiS1d7GjMa2ZpxZlv632QB38JVw2NxfanyiQ/M4PEQjNQC4Af
 YpfBZkx5zmmSZBwyHTjNRZacLXCbiPUg6CCUDy/MmLhp3I52/4FSKCUvjtf3vyidpDvoRQUWU
 h3xzw0eeH6W5aCnrUcFDWfO2SSxsQ1grVqj6dcXxN5NKNz3IGe7ODK0Gd7DpZcfjtD3vXO59J
 X85ARKJAsYQtrXezmdxrSdTPNoCq1Vvvu4+0OuBiDkzm1PLfOuJfh0Nz8a4kQohiKu/2BBVUd
 KUtnMArnr3mIQft1Ek9h9LmOWAGFFYto+d+l3f+X6z/89kqiYaJXoWisUXjz62naU3MbX9zX0
 OUn7PV+2Vo5ZmWQxmMJl/dt+D+el/mncYtgFjzlO8WgOra+bvUcS6gz/1qvI5m0J47BE59DMB
 ZfBDfzSm+BrepcKIx7PBzmLAmCHwhmdsFPqOpO1RjqPLdwFI4VbPUCDAU48bjACjNWqZJgv3+
 dlBRiY1ERVKsEvcyHmGhU2yA3Fad3NVcEqcjTDulnZHckD37Dj6CDXUibCeXP9T3RPATuv4Im
 12f4c/8bgUVQ+WwdJfEjbXnUHXoxufVuX2/h991V7wp3t4qT7C/lVfUqUNsFii5adxjfC8wVP
 /MGu62ZzqDeOWzfttSvzSRTb2Fv3L8qUFCw4AZzzeMp0XZSR84Wg8evGCmhQUvAqhWeDpkcD2
 ssiDplKf2MaZ5DwshxuRpHzg==
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

On 11/4/24 18:51, Simon Glass wrote:
> If the filename cannot be set we should give up. Add the missing error
> check.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Change the tag to bootmeth_efi
>
>   boot/bootmeth_efi.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index e8109e19bcb..1ff8788ebeb 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -269,6 +269,8 @@ static int distro_efi_read_bootflow_net(struct bootf=
low *bflow)
>   	if (!bootfile_name)
>   		return log_msg_ret("bootfile_name", ret);
>   	bflow->fname =3D strdup(bootfile_name);
> +	if (!bflow->fname)
> +		return log_msg_ret("fi0", -ENOMEM);

How could we hope that a user understands a cryptic message
"fi0: returning err=3D-12"?

Please, write a message that is user readable.

log_err("Out of memory");

Best regards

Heinrich


>
>   	/* do the hideous EFI hack */
>   	efi_set_bootdev("Net", "", bflow->fname, map_sysmem(addr, 0),

