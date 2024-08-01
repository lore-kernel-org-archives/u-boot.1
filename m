Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCDBC3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 09:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E8CF86DBD;
	Thu,  1 Aug 2024 11:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="SFLhAGGA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8FAA88606; Thu,  1 Aug 2024 11:46:44 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5682B88AD9
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 11:46:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sw0312.kim@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240801094637epoutp03268fe99c6465620183ad2d0d4d1ec1a9~nkbbymTDH1668416684epoutp03U
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 09:46:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240801094637epoutp03268fe99c6465620183ad2d0d4d1ec1a9~nkbbymTDH1668416684epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1722505597;
 bh=UpgjkvKQCZQe4fPU5YXjSI5jliiduW6nlYNh5iCwR5Q=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=SFLhAGGAl9C+ci0AHzuXEOCh/S4fZEBau4QkhPyTvZP6bF6/yfkqDr2/PXXVCpuHk
 JzUGjcKbROJUQhQd8TNjFuS1ui+xmj93eSmFhql85o41C7cF6UWOcyQjrBEEF7xj5E
 za7lOfyAbC4eeyLQXRMB70affvJtxz2q7fYwIBgo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20240801094637epcas1p11571a618cf7fa85c6e87f641d9919b25~nkbbeE6Ai3158431584epcas1p1n;
 Thu,  1 Aug 2024 09:46:37 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.231]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4WZPHc1BLRz4x9QB; Thu,  1 Aug
 2024 09:46:36 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 D3.F2.09734.A795BA66; Thu,  1 Aug 2024 18:46:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20240801094634epcas1p243900bde24a92752c231560d3357fe69~nkbYtf6Cu2578225782epcas1p2r;
 Thu,  1 Aug 2024 09:46:34 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240801094634epsmtrp18295c043d135d9ff86d5efb7a9903c46~nkbYsr2aB1934419344epsmtrp1F;
 Thu,  1 Aug 2024 09:46:34 +0000 (GMT)
X-AuditID: b6c32a35-babff70000002606-f0-66ab597abf89
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 5E.9E.08456.9795BA66; Thu,  1 Aug 2024 18:46:33 +0900 (KST)
Received: from sw0312kim01 (unknown [10.113.111.252]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240801094633epsmtip2052a4f3094d3c88f0b72c1a2f1443e78~nkbYZLCnw3267832678epsmtip2j;
 Thu,  1 Aug 2024 09:46:33 +0000 (GMT)
From: "Seung-Woo Kim" <sw0312.kim@samsung.com>
To: "'Andre Przywara'" <andre.przywara@arm.com>
Cc: <u-boot@lists.denx.de>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <jh80.chung@samsung.com>, "'Samuel Holland'"
 <samuel@sholland.org>
In-Reply-To: <20240801102738.38ed300b@donnerap.manchester.arm.com>
Subject: RE: [PATCH] tools: imagetool: Remove unnecessary check from
 toc0_verify_cert_item()
Date: Thu, 1 Aug 2024 18:46:33 +0900
Message-ID: <019501dae3f7$b1b2e710$1518b530$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHQu7eugU3HkAtUHh+5Hnt+EcbTsgJGCOREAgm9bzmyA/fOgA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmnm5V5Oo0g4MHtC1WzPvJaPFl0wQ2
 ixu/2lgtnj/qZLOYMfklm8XUSZvZLd7u7WR3YPdY+/E+q8eaeWsYPV4dWMXucfbODkaPvi2r
 gNyvcxkD2KKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTd
 MnOAjlFSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgW6BUn5haX5qXr5aWWWBka
 GBiZAhUmZGcsmLKVuWCmYMWes//YGhhv8XYxcnJICJhIrPt7n72LkYtDSGAHo0Tr3L2MEM4n
 RonGP3OhMt8YJQ71PQXKcIC1nDzqCBHfyyix8NEsqI5XjBJ3Z+xgA5nLJqAncWzTeUYQW0RA
 X+Lwl5dgRcwC0xglHi++AZbgFHCSmHPkCjOILSwQJ/GxZQ87iM0ioCKxoekWK8g2XgFLiRkt
 VSBhXgFBiZMzn7CA2MwC8hLb385hhvhBQeLn02WsELucJHbdfglVIyIxu7ONGWSvhMBKDomz
 c4+xQTS4SNy88J8JwhaWeHV8CzuELSXxsr+NHaKhmVHi/bNbjBBOD6PEhmkLWCCqjCX2L53M
 BHIds4CmxPpd+hDb+CTefe1hhQQRr0RHmxBEtYrEzqOT2CDCUhKzNgRDhD0kTre+YpvAqDgL
 yWuzkLw2C8kLsxB2LWBkWcUollpQnJueWmxYYAiP7eT83E2M4ISqZbqDceLbD3qHGJk4GA8x
 SnAwK4nwCp1cmSbEm5JYWZValB9fVJqTWnyI0RQY1hOZpUST84EpPa8k3tDE0sDEzMjYxMLQ
 zFBJnPfMlbJUIYH0xJLU7NTUgtQimD4mDk6pBqap5xhdnNyLjd3KHnJLKmf5/tO78U7ve5te
 VjdTrc1Ce26J3RIi8vMjVsWwiApz7y5dcPDOhAVLV16KVTg0cdfPrXnsHvLnd3icCKu3cXm3
 S+ylz7kG3z315o3mp6cLqt4xkNSJ/JyQzbaqgmXDqS+nAm385HtnN2nqr7U6wz/H6mRV3LMM
 k7bTK3w/yz4UjBS/u++rYGGmG0fM/J2T2YW0djmr7O3QzbtwWOPZivuN91dEvAn2KdKX6vFl
 nM344X315bvsr0ONjh3uirt5jWWF5IO7t5Ya1bkpOu+ePz1sZ8mJNhtDocl+bvwhSbo3Wibd
 Zm6sYV3Qx8G7YuExu7xj/h+f7dhY/mxuyDfxZiWW4oxEQy3mouJEAEDIU04xBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJXrcycnWawaW5lhYr5v1ktPiyaQKb
 xY1fbawWzx91slnMmPySzWLqpM3sFm/3drI7sHus/Xif1WPNvDWMHq8OrGL3OHtnB6NH35ZV
 QO7XuYwBbFFcNimpOZllqUX6dglcGQumbGUumClYsefsP7YGxlu8XYwcHBICJhInjzp2MXJx
 CAnsZpRYubiNrYuREyguJTH323ZGiBphicOHi0HCQgIvGCV2LlUGsdkE9CSObTrPCGKLCOhL
 HP7ykhFkDrPALEaJxg3n2SCGHmaUOHz8NTtIFaeAk8ScI1eYQWxhgRiJpgN7wZaxCKhIbGi6
 xQqyjFfAUmJGSxVImFdAUOLkzCcsIGFmoGVtG8F2MQvIS2x/O4cZ4kwFiZ9Pl7FC3OAksev2
 SxaIGhGJ2Z1tzBMYhWchmTQLYdIsJJNmIelYwMiyilEytaA4Nz232LDAKC+1XK84Mbe4NC9d
 Lzk/dxMjOKa0tHYw7ln1Qe8QIxMH4yFGCQ5mJRFeoZMr04R4UxIrq1KL8uOLSnNSiw8xSnOw
 KInzfnvdmyIkkJ5YkpqdmlqQWgSTZeLglGpgKmw+LdwRoDIzb8a6JsnF5xVUt0TrTJ748Ujb
 ipd5uXeFpXLuzD6ulXXiptCEmXGJb5UmsXx+k7rTT2nfxIyTRQL6y6cY9q1sO1u7mKfgx7x7
 zpMEXq47+XRSbkCywoI7P/1UV3eEMxyoX+BwKiBNIuZX59LSt7dfnO7Yv9eu5+0GZcnaCabz
 z7sHPFyUKF38+5TqfU5Lpp49j7effvHIad0nran3N7F8nFu/K8rGPUdc1o+9Zf70szNSJx9c
 oCpbm/S75tOU/w6MkhXLZl4LUX4qeyD0kbuWm/PCjlDWrz85+td9XXkv8P/ueUfnWBjMSmBo
 TJVJ6Eqc1ZG0w0eg+9bae49/Lj1/WntK0aw9cpOVWIozEg21mIuKEwGTqd5QGAMAAA==
X-CMS-MailID: 20240801094634epcas1p243900bde24a92752c231560d3357fe69
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240801010104epcas1p3aadbfa545c1f7e0c7d91c3175614ab99
References: <CGME20240801010104epcas1p3aadbfa545c1f7e0c7d91c3175614ab99@epcas1p3.samsung.com>
 <20240801010100.21009-1-sw0312.kim@samsung.com>
 <20240801102738.38ed300b@donnerap.manchester.arm.com>
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

Hi,

> -----Original Message-----
> From: Andre Przywara <andre.przywara@arm.com>
> Sent: Thursday, August 1, 2024 6:28 PM
> Subject: Re: [PATCH] tools: imagetool: Remove unnecessary check from
> toc0_verify_cert_item()
> 
> On Thu,  1 Aug 2024 10:01:00 +0900
> Seung-Woo Kim <sw0312.kim@samsung.com> wrote:
> 
> Hi,
> 
> > Remove unnecessary null check from toc0_verify_cert_item() because the
> > array digest is always not null.
> 
> Do you mean it's always not NULL *as currently used*? Because digest is a
> function parameter, so within the scope of this function definition can be
> NULL.
> I agree that *currently* there is only one caller, and this passes the
> addresses of a local variable from the stack, though it's never NULL.
> 
> But I don't think this check hurts (looks like the compiler removes it
> anyway), and it makes the code more robust. So is there any problem with
> this check? Why do you want it to be removed?

Because in my gcc-14 environment, it gives -Wnonnull-compare warning.

tools/sunxi_toc0.c: In function 'toc0_verify_cert_item':
tools/sunxi_toc0.c:447:12: warning: 'nonnull' argument 'digest' compared to
NULL [-Wnonnull-compare]
  447 |         if (digest && memcmp(&extension->digest, digest,
SHA256_DIGEST_LENGTH)) {
      |            ^

Regards,
- Seung-Woo Kim

> 
> Cheers,
> Andre
> 
> >
> > Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> > ---
> >  tools/sunxi_toc0.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/sunxi_toc0.c b/tools/sunxi_toc0.c index
> > 292649fe90f1..76693647a095 100644
> > --- a/tools/sunxi_toc0.c
> > +++ b/tools/sunxi_toc0.c
> > @@ -444,7 +444,7 @@ static int toc0_verify_cert_item(const uint8_t
> > *buf, uint32_t len, RSA *fw_key,
> >
> >  	/* If a digest was provided, compare it to the embedded digest. */
> >  	extension = &totalSequence->mainSequence.explicit3.extension;
> > -	if (digest && memcmp(&extension->digest, digest,
> SHA256_DIGEST_LENGTH)) {
> > +	if (memcmp(&extension->digest, digest, SHA256_DIGEST_LENGTH)) {
> >  		pr_err("Wrong firmware digest in certificate\n");
> >  		goto err;
> >  	}


