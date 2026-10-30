Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FEA606A320
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qkkX0mIc;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=H1FDeohi
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E56C607B6;
	Fri, 30 Oct 2026 12:45:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C8PSTLY6wKSb; Fri, 30 Oct 2026 12:45:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4288F607A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793364327;
	b=O3JBEfZMb3P13neYLZpamUjtpfZS6BN4jDQkvAkLIr4esstV6tBeQvPf9z0MXoqrc+YU
	 XuWBfF1VEGCZrEchdQsbClnuxg80ezsPQVAtJXM+tystHCKHNeU+61sa910+ZHP20sINz
	 hdCL6a5NxhvIgoPnETQj8Ws/6nzOO4NLczybpcz75Rg0M/ik9o3sBIp3SE3fJqZYlk3NC
	 q+lxPnFlxddXENC/BghgFjrLJNd496geAYtfJ/xHaqqmAbcESpb678aS+fxBxrL/zQLzT
	 y1TjLfZ/drytUwoiDtlHfjEHnyziNacfCLD+IsckLUGvCmaWb7JtyMTkKANvzblL57A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793364327;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XqkMzphMCbeqxUYPIx6Lc+3xY9YRq07ZjF/eMvLJpgY=;
	b=G42qPwVugtLRdUX55hdoDpi0JMuJ9Q5Hd249Qi0EVe6tLFVatl1ga/TNXgrL8LJWcPqR
	 Nfza/3biHlJ6T1QIpjaa/SRUYJHzSPkmkZUjA16JbDOjPB82q9Dw3NjWR+yYVXc3s4Ldf
	 ed15Bvmo3iZBlqGRPep9XkVdTeqWNKx1UV2GxHky2GGJknh3CmeS35CvTL232Ho6uVlLC
	 Uv+E3K+fWs4q+oceeSXFC/RaVJuNewaWs04S29Ntblm1pBDEIb9BzpufDTpwQVKcRWeDz
	 eNajwC/dAwJoGWPC1lH7i6od6UWT+djxqyxdzCJIaYAePgQav8dibRQXZPy/UInHZXg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793364327;
	bh=XqkMzphMCbeqxUYPIx6Lc+3xY9YRq07ZjF/eMvLJpgY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qkkX0mIcv8+55MxdA1pOzOer7lkKzN3+Pxpm+gSpBz4TaBC2Euv5A7QMec35Q9UEn
	 qTsD6ra7r5gd6BRVmqY791F38WUayeI1Tih+3sBHIfNJh2Kall+IFCZlpFUf/QqE9Y
	 JT3rRLePBsxO+GC2mTj9KNElsmumcZcuqaHAWxAgdi/6w63DgoYUgeA6+SQNG/kavC
	 tFgCFtZ2W6dGrPcB/vvT9XNX6o8EJ9S350K0Thbp3ACedL+Hzq/7l6f818dvMdpE07
	 /6L7erv/+tK6Jy9fayyEKRMA3jFJRUa3efgSa6JpxeHIc1hw5vMOzUEO+N8OKxlUkB
	 ndKHYRFpPoOFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4288F607A0;
	Fri, 30 Oct 2026 12:45:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EDE7A362
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF9874052D
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:45:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HsyERhXoHcO3 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 12:45:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C273140243
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793364325;
 b=kRWzTz3Sy0hNAXMmm8QtnBfkVGVUVzdi1LjkW0SexlmE15lDc4T5AhwRld4W8vIDlNRg
 jHHp2MRxtIe72KFe4MilIbRSVQ/vMgJfsYFM6GucP5NumYtm8Xde0sGVsnW+UaJTT2QBy
 mVlwi1xTQ8cO5QAbWm6iZ47XYC016i8VaIigqflTCPAuOOsbSZkLNt/YLG2Aih0VOYYx0
 5MYn2upHaLISz4ThVDzvNZrSLCgrop28KnJYjn/oCjGYc3VNZWG+s3w8tkM4/5XQbGolf
 zb165T+9teNnPlxrfyR7Ukpu97veMkApJKdSFlYwE5pA30qZKBoKOic2ALsJs5lyroA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793364325;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=XqkMzphMCbeqxUYPIx6Lc+3xY9YRq07ZjF/eMvLJpgY=;
 b=pzmLjNTOzuAyc2CYFt/4h5b8MQTrT6X915rQnuVbGTFejsfgbeIIqGztxCyeLDmRizAd
 6oUZ+9fd37sckxsuOzylZ1LLf1n1HRKCr4sxaus2LQiavZvzeSejdV1TtvLZDpAkWXuQx
 G+qxbFI0Y8cAsVlRSrkc+fT3FxDUupSuszKLHVCsD8Og9trf4f61SIWbxymvsucyO1ylX
 Rjrk2XeSgpC1+2CwEn9k00E6YjXe/lMGeJmSvm8NXJE03X3mWEoXsMRJgy447HpX+nLG5
 fmE/Qt8No4Uz2XsiP1MNBl5J5TSW1NLtpuBwY31TZFvn8wgpJOM9fmgAuAbjlGBJAsg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=H1FDeohi; 
 arc=none smtp.remote-ip=212.227.17.22
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.22;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=H1FDeohi
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C273140243
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793364320; x=1793969120; i=xypron.glpk@gmx.de;
 bh=XqkMzphMCbeqxUYPIx6Lc+3xY9YRq07ZjF/eMvLJpgY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=H1FDeohifEivRzgZQISk1CHY2pRZSO2z1ijEvAVSH4nh/NGRdiFR5I4v91niOr1N
 xcn9p8W9Y9Wh5oYCYOUQjcK5ZGCm6xewEpC54xM29WxIFQiicfgkeDxIBV0IPADWd
 JA7zghnZojOcsOq5OC/UI4mehTmn58Lyt1eV6KWyoCXJE8/uz+VJvDQLr60DCsCz5
 kweo1/aLZYNdAwB9XIj0Y2Fu2WurPWnWV60P8GVxOg86y98tVw8c3Ww8gDfgOquXy
 SEBXeoQ/AUSaRw8NXrXNHaaWYY03Y4nUq4MT97Ur/FaXDFZLJrTBSoqxFEDpgpWe5
 bF9ne+8t95Y+y36aKQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dsb-1wQhgD1BeX-00z2Dh; Fri, 30
 Oct 2026 13:45:20 +0100
Message-ID: <9b5df6ed-a983-4f63-ab78-17f6d6e0a332@gmx.de>
Date: Fri, 30 Oct 2026 13:45:17 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] efi_loader: check PE section raw data against the
 image size
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
 <50414814-4aeb-48f1-8630-ab51c6eb9a9a@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <50414814-4aeb-48f1-8630-ab51c6eb9a9a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:chy8djGU0JFf4J/pCACHHOc5bSrq2Z/+xSxlFuVzeHE9Kgr/03D
 L91pLeQGowbDRe4zbmzGgFreihMYPCloH3dtFn/uhNsp0lipMSAZxKrynEvFNWqBpea3gME
 t96WoBpB/aO7+BUF/xW3tHTJ7K0uYWKkbe8JxljcdMup/fpuhGQqTxl9zaNlqQIkkBWumdN
 78un9HKRWXDeA1Dg24sZw==
UI-OutboundReport: notjunk:1;M01:P0:rqFzFUdqeEw=;5RTcJRUYfZpWHy7lZApWdsYTZdd
 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
 v14rsj
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 07:14, Ana Bobillo wrote:
> From: Ana Bobillo <anabobillo3@gmail.com>
>=20
> efi_load_pe() copies each section from PointerToRawData in the image
> without checking that the copied bytes lie within the image, so a
> section pointing near or past the end of the image is read out of
> bounds.
>=20
> Reject such a section before the image is allocated, as barebox, whose
> EFI loader is based on this file, does since 552a54e4d357 ("efi: loader:
> validate section raw data bounds against image size").
>=20
> This runs before the image is rejected when Secure Boot fails to verify
> it.
>=20
> Fixes: cb149c66342c ("efi_loader: Add PE image loader")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
>   lib/efi_loader/efi_image_loader.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>=20
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_imag=
e_loader.c
> index b15a662e5d6..7fd03ac6211 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -1075,6 +1075,13 @@ efi_status_t efi_load_pe(struct efi_loaded_image_=
obj *handle,
>   			return EFI_LOAD_ERROR;
>   		}
>  =20
> +		/* The data copied for the section must lie within the image */
> +		if (!pe_range_ok(efi_size, sec->PointerToRawData,
> +				 min(section_size(sec), sec->SizeOfRawData))) {

All of raw data should be inside the image even if VirtualSize <=20
SizeOfRawData.

Best regards

Heinrich

> +			log_err("Section %d exceeds image size\n", i);
> +			return EFI_LOAD_ERROR;
> +		}
> +
>   		virt_size =3D max_t(unsigned long, virt_size, end);
>   	}
>  =20

