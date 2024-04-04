Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC744CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 18:23:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98FA388259;
	Thu,  4 Apr 2024 20:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HIaTJMcR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E05688212; Thu,  4 Apr 2024 20:23:10 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEB1588274
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 20:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 434IMrmi111489;
 Thu, 4 Apr 2024 13:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712254973;
 bh=ds35N38bJSlYqB5CNp0yoXqUhGPlgYkZmZBCnVC2/34=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=HIaTJMcRJNgpwdN5qVeoOuAWVw6/gw5vfhNkQKXbz1Mwbj2t7DBaCnm/+9Ims4AqQ
 32mC8hTDLZNnwwcoGkAPtQ/vJP+PsOeDwjE3fAQiMPszHrQXijYkQ7Z0Yys8gD4kP4
 QYBio4p8r1b9SWmFJr9JMO3UJuGkZZTg4JQEtOP4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 434IMq7R001265
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Apr 2024 13:22:53 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 13:22:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 13:22:52 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 434IMqLu032549;
 Thu, 4 Apr 2024 13:22:52 -0500
Message-ID: <1b87f190-342e-4764-b3b3-476f552ca45d@ti.com>
Date: Thu, 4 Apr 2024 13:22:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net: nfs: fix file handle length in NFSv3
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
CC: Guillaume GARDET <guillaume.gardet@free.fr>, <u-boot@lists.denx.de>
References: <20240326093431.23962-1-sebastien.szymanski@armadeus.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240326093431.23962-1-sebastien.szymanski@armadeus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 3/26/24 4:34 AM, Sébastien Szymanski wrote:
> The NFS protocol uses file handles to refer to file or directory.
> In NFSv2 file handles have a fixed size of 32 bytes.
> In NFSv3 file handles have a variable length up to 64 bytes. This is
> also true for the MOUNT protocol. [1]
> When the NFSv3 server replies with a file handle length > 32 bytes, U-Boot
> only copies 32 bytes of that file handle and the next LOOKUP Call fails:
> 
> BIOS> nfs ${loadaddr} 192.168.1.51:/nfsroot/opos93dev-br/boot/Image
> Using ethernet@428a0000 device
> File transfer via NFS from server 192.168.1.51; our IP address is 192.168.1.133
> Filename '/nfsroot/opos93dev-br/boot/Image'.
> Load address: 0x80400000
> Loading: *** ERROR: File lookup fail
> 
> done
> BIOS>
> 
> Looking at this transfer in Wireshark, we can see that the server
> replies with the following file handle:
> 
>      length: 36
>      [hash (CRC-32): 0x230ac67b]
>      FileHandle: 0100070101005e000000000091763911f87c449fa73c298552db19ba0c9f60002980cfd2
> 
> and U-Boot sends the following file handle in the next LOOKUP Call:
> 
>      length: 32
>      [hash (CRC-32): 0x6314131b]
>      FileHandle: 000000240100070101005e000000000091763911f87c449fa73c298552db19ba
> 
> Fix this by using a variable length file handle for dirfh.
> 
> [1] https://www.rfc-editor.org/rfc/rfc1813.html#page-106
> 
> Fixes: b0baca982048 ("net: NFS: Add NFSv3 support")
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> ---

Fixes NFS boot for me, thanks!

Tested-by: Andrew Davis <afd@ti.com>

>   net/nfs.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/net/nfs.c b/net/nfs.c
> index 7a8887ef2368..c18282448ccd 100644
> --- a/net/nfs.c
> +++ b/net/nfs.c
> @@ -57,7 +57,8 @@ static int nfs_offset = -1;
>   static int nfs_len;
>   static const ulong nfs_timeout = CONFIG_NFS_TIMEOUT;
>   
> -static char dirfh[NFS_FHSIZE];	/* NFSv2 / NFSv3 file handle of directory */
> +static char dirfh[NFS3_FHSIZE]; /* NFSv2 / NFSv3 file handle of directory */
> +static unsigned int dirfh3_length; /* (variable) length of dirfh when NFSv3 */
>   static char filefh[NFS3_FHSIZE]; /* NFSv2 / NFSv3 file handle */
>   static unsigned int filefh3_length;	/* (variable) length of filefh when NFSv3 */
>   
> @@ -377,9 +378,9 @@ static void nfs_lookup_req(char *fname)
>   
>   		rpc_req(PROG_NFS, NFS_LOOKUP, data, len);
>   	} else {  /* NFS_V3 */
> -		*p++ = htonl(NFS_FHSIZE);	/* Dir handle length */
> -		memcpy(p, dirfh, NFS_FHSIZE);
> -		p += (NFS_FHSIZE / 4);
> +		*p++ = htonl(dirfh3_length);	/* Dir handle length */
> +		memcpy(p, dirfh, dirfh3_length);
> +		p += (dirfh3_length / 4);
>   		*p++ = htonl(fnamelen);
>   		if (fnamelen & 3)
>   			*(p + fnamelen / 4) = 0;
> @@ -565,7 +566,14 @@ static int nfs_mount_reply(uchar *pkt, unsigned len)
>   
>   	fs_mounted = 1;
>   	/*  NFSv2 and NFSv3 use same structure */
> -	memcpy(dirfh, rpc_pkt.u.reply.data + 1, NFS_FHSIZE);
> +	if (choosen_nfs_version != NFS_V3) {
> +		memcpy(dirfh, rpc_pkt.u.reply.data + 1, NFS_FHSIZE);
> +	} else {
> +		dirfh3_length = ntohl(rpc_pkt.u.reply.data[1]);
> +		if (dirfh3_length > NFS3_FHSIZE)
> +			dirfh3_length  = NFS3_FHSIZE;
> +		memcpy(dirfh, rpc_pkt.u.reply.data + 2, dirfh3_length);
> +	}
>   
>   	return 0;
>   }
