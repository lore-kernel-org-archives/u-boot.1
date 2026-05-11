Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA41CCD484E
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 19:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02F3083EEF;
	Mon, 11 May 2026 21:24:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BKVhzKH5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CAAF83E36; Mon, 11 May 2026 20:28:14 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC7C483C2B
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 20:28:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kavita.mnnit@gmail.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-69b2eea8f1fso1359483eaf.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778524089; cv=none;
 d=google.com; s=arc-20240605;
 b=JmcUKiBiOaAzHnPXS5VmE9J8oiwecZf50dv5XeVa1wc06S/jHgbR5dNvNmTeEJdQH2
 i2SZvujhNgEdBIZWB6h3EOcVTz8Qzk6qvXyRxD9BobKYDDU7vekDtKfQmo7uCVTFpzxV
 tmaXCnSD5EqzzikAECHnzRkOrAdy5HZG8GJmh9tVA6QUvw/gnQYhLEaEDo6twQEOVEz1
 EqhREJUr8AIm3VDXPg4nCsWRM6UMPSZCtSKRr/q5rgPsdboA/q8iHd9T/0pCjAF1hYom
 LgV8XyOrvLSlYxkCoD/+ChwNrNQISGvdVL6HQOVyigIWRdifA6sFz2j/No8InqupBKOh
 s1jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=1Feehbs2vOoo33nPhtdDPPwr5pE4XhasMqjEFXUIuwI=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=YBDqIcc0zBqNEGgfiIK2yTSljzAXMXKDz7hwI3a/aCQHLj1VlOFilDrsvi771GTinu
 F+jAAeoAtQ/6/V6fWCx266wRR1IRN3Fxjz85CB8yRx+AKLIDTqDzoeTnRVyzR+qLnYp7
 kunPHAUHqRlWusKDTtmifi0+56ORro1U/vTkPhHC9OeR9rcVvi33yBylp88XaPjTiqe3
 iSJYtm9MPwO0BPj4ta3Rx/t5n3LyxeFMDgrxjIM/pnnQ7WupYT3XE7LUt3KLGdmuds1i
 RSqbOPf/7AU72r0H+fCPZEp16+hu3sxD61/4PklpPDihMdVRvyHO4FzV25aDl21MC5PT
 nxZw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778524089; x=1779128889; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1Feehbs2vOoo33nPhtdDPPwr5pE4XhasMqjEFXUIuwI=;
 b=BKVhzKH51+S1YKF9tfaVVQPLZDak2dkSccvwBe14rWLWpl+uQBruwUcUSR5YcFTImc
 d7ApifSUywjeK1/dPvOwgTi3V2uSEkxajyQMfvTlksE68wJ9ia9vQknRtaUmB3GN40ej
 VX2Et/RnzxBwsJLbHB+hINLNeF93m04LWCI256IQV9fkWR5LYbvpLUyKM3O1GPQQ7DCJ
 ktsMTK4qp+bXtFJllPUkKUxFNAzw/h4TrsBDbS7+pzaLjhJCvH15dqnICd/jEDtXNtpu
 3IRSHjIP3Z3TULFJOX5RLR4M6GkVdfGRy4KgePuscKoA9BC6Ggfk6mYc1Rr6bspea2ye
 Yweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778524089; x=1779128889;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Feehbs2vOoo33nPhtdDPPwr5pE4XhasMqjEFXUIuwI=;
 b=TxZZnPGAFeCzcb+uOwI1763t/Eb5bSyfaK6WCGR9T84WoqzcHZ+gei4VKWqzraGExP
 biIDhtyVRWnHqQdrxv7rkJvVz4PoaeWQ5OtZSSN+uLCjuhGQIVVy0iewUHQgeevHRVLP
 OZFzv7T902NOAqd7ZhGgtH1Xs9CwDaw+Ddi0XCfZ7RnNX8jggErSa6rt2/Vvl3IJt6Hd
 o5tP+kVdhTAUPeP+DMLWhTVkkYEbnARFXq7ObUdyEx4VBkzn7DCgQ5AlmWY8iEHOnw0v
 +6IS/0mX9KO9QNYUfnovU3fG4DVGu/zSPz4XEmJWb3AgZp4KHEVVMFGmhcN/x/Z1C2+F
 xjQg==
X-Gm-Message-State: AOJu0Yyaj4HCske1NFNfjAol7uDqx2lbXmeeEGB2eM13lGdHTuiPVwIn
 eOWml1iKa+pRvlLVZpJVn3fw8/FcdSc20OLx6egRT9Kzws8uumFdvQebRY0UUwYs5hr0Y13uT0J
 FnhYi+/iifvOYnegAQV4CANSeNWHZDnSg7zvoyBc=
X-Gm-Gg: Acq92OHp55G/Wl/8/A4BdHrwPg+Eo6vgruKx2PECQNm+Ne8LvOge0G7RKTd2po0r5We
 3M+mTZ5YPk/7KR5m7cYT7IPN1laDDwSCzbsCX/4n3p6V54ZqfjTXTO6NC2easSraZpV3GbEgMjz
 IUjm1TZsSDWBygXMmkU8htTHpxJgy1L4M9NYqSUfTXovNp4N8NjGMVEnz6jEIzIe/ZsbjNeVYN7
 pHYFgh0Hg7PaXEFppfTiO0RN6GecyVL9KgYC9TA3d+WOard/fJSHN3+G1akVFhpRggvy/41mUvz
 QSuU+aXHfcw1TjlrVm4LyqvpKv4XoBwgnCfC21dffJx8MucD3Q==
X-Received: by 2002:a05:6820:c31c:b0:69b:544f:b2e1 with SMTP id
 006d021491bc7-69b544fb438mr2082105eaf.2.1778524089341; Mon, 11 May 2026
 11:28:09 -0700 (PDT)
MIME-Version: 1.0
From: Kavita Awasthi <kavita.mnnit@gmail.com>
Date: Mon, 11 May 2026 14:27:58 -0400
X-Gm-Features: AVHnY4Iqp8qkBjaPCxWudF9InuUSQKm5ewP-uj2jnh8Wc0ekVa0dXUgLcy6t1lU
Message-ID: <CAP3gb7avhnVqkBAMg-2f5GXZ_7u9rU+Dm2UoNhYHKdvBj64Vvw@mail.gmail.com>
Subject: USB3.1 detection Failure on u-boot
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Mon, 11 May 2026 21:24:26 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Dear community,



I am struggling to find a solution for USB3.1 Sandisk key detection on
u-boot. I am getting following error Bus usb@32e40000: USB EHCI 1.00

scanning bus usb@32e40000 for devices... EHCI timed out on TD -
token=3D0x80008d80



      USB device not accepting new address (error=3D80000000)

1 USB Device(s) found

0 Storage Device(s) found



I have tried a lot of solutions, retrying this step, increasing delay but
nothing worked out well. I am seeking help to fix this issue.

Here is the link to USB key:
https://www.amazon.ca/SanDisk-Ultra-Drive-Type-C-Flash/dp/B07YYJ63VF/ref=3D=
asc_df_B07YYJ63VF?mcid=3Df22780ab44ce3a3baad4b52ec9169584&tag=3Dgoogleshopc=
0c-20&linkCode=3Ddf0&hvadid=3D706724917347&hvpos=3D&hvnetw=3Dg&hvrand=3D160=
19694204985405935&hvpone=3D&hvptwo=3D&hvqmt=3D&hvdev=3Dc&hvdvcmdl=3D&hvloci=
nt=3D&hvlocphy=3D9000441&hvtargid=3Dpla-858626018619&hvocijid=3D16019694204=
985405935-B07YYJ63VF-&hvexpln=3D0&gad_source=3D1&th=3D1



Thanks,

Kavita Awasthi
