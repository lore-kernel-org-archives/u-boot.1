Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DB1606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 03:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=E0uXr1oZ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mlttDrJW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27EE380C17;
	Wed, 28 Oct 2026 03:07:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C23AiWq6tcf9; Wed, 28 Oct 2026 03:07:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7932580C33
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793156837;
	b=DNvENLz3iGpqsoej+Ysnwiggaj+GFV5DeTrFB/pmt2dUg+YayzgfNloV8IJWEZvex0/1
	 29PtQGioST091+Y80PfF18SZynnV1Nq2FWY8YYBggWIzJHx7uF4ejlVCyM6gbH1RO8QTP
	 WfmOsrOZdJAoMqbo4baposwxF6d3Mu4RyaNIN+GR1DlKN2gi64/wP3teupZEulSCX0I6p
	 qAhIrgQ/1R6doQZU4ffq6oUYe1ZCYW470hvFXsUQ95+7BGRVTA5wXWZaarjoFuiviJlGZ
	 ZwNoEGsLshajO+ld6p1+mYY2WeUiWMStu8kwundtiyyPYAIiI+4ADm1xbC1QULTYHsw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793156837;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YVcyt8U4IFRF6jJNK3AhRUZq2Xye53lpxZ160TnQfXI=;
	b=J4WZRamSRcNMiUbVB0J9xTRWlHWNYwbjQCasZ7aU30Jiq/C3w4IX4t5ycFbHc/IDVqGq
	 ztR42k3gtEk72BkY68J5Rj+HDwbD9o8tUkSMRKBHSJfCjCSeXTkPpsY6iIn5QajmF/N2I
	 Fi8k3iI6RRyT0SljWMP7+dDr7l5Bw/0nXmoxeuN8kX++QafgiL7O8hwmyXie+vCUbef0k
	 PA6pGVhKMlHxtX35k6i3OURnJwS4sPBlYd2iM9gQY7ABNa5B2wru9deJj8omruBXoiZFD
	 7MdTJAqEqmdR4JIzRLVyYx4kCNMhWAzWuT52XCk87hNipKcunpY7T8Ab3uD3TByjV9Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mlttDrJW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793156837;
	bh=YVcyt8U4IFRF6jJNK3AhRUZq2Xye53lpxZ160TnQfXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E0uXr1oZYURu//SlrpiN5nGHzR2dT8gk/hNnjkY6ZVA/AzBMTzHja67/eCd5v1DxP
	 waQjO/Af3jWAxtcEYxD3gRZ39rsrDlzgAoPJlFSqfxIXbwtE/w9qb3/qRP7kzv7wTs
	 ZfltxMwfmOxToYpF1fX/83T8eWdEQi3o+3FFBQCX8v1LNpazaLlzRkC4FZoZC07fd0
	 mkOQe0lBOtgD/u0L20C11Kig+hL/oVygQwwYOTHotCz6VbRQ3q8CVl4q5zw3iUlRPh
	 dMmRi6E6dXJ4nVum0ycmYxuamjKRb4OiXbedPbP7FlHF+ml46ET0x7Gx6i2xdlsj/S
	 2qWK2681fzA9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7932580C33;
	Wed, 28 Oct 2026 03:07:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A01D7972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:07:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 91A4F80C33
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:07:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tO4FdJU56UZh for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 03:07:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DEFD880C17
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793156835;
 b=BjfV8i2XFx9lhjSqp9IZb9+gv6qvrTXOgtA1p5KZiRz7BeoLM3rRXnbulcqz64Vx4zgu
 DLIicQqfkkMRmoqu5ox4h8HG5dlGAhAhbN+XHdLuQGWDzGMI2JpCdnVFrxxBepEsyGpso
 T9M/M91LYwUldkHPq8KUToe5U97dv8hyfL5ATbnHk7Vk4id5/JIPXBoqIc1nvFtiNZ5DW
 9O1vD9EEMzJF81ZFIpmY3TmOyq888MPLvxmykiD8rgw8kRQ0zto+10Yhk/1GMSRRj6Oju
 FwcANgsGK/Zge+FFoUT9xiLVuiu+KZKngwCObkf7mR9/pcen4zp2iZLBgzlfDSKyT6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793156835;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=YVcyt8U4IFRF6jJNK3AhRUZq2Xye53lpxZ160TnQfXI=;
 b=JiE3i6bzYU6Q/SR8DoSW8lsWAvFvk1I5WgjWmR8KHjNBSVYSR0TLKyWvdW80lFe88EdN
 S7xoLIY26dkFPBem6RFOZZ21ONwKxIJgxXjxEMV2P0l/eJlyTvcOVL8W3jWRGChLzpPRx
 aeBYvx+NxPr6B8XPlMtrywBViivZ5/nnsidnB5tSh19NEdDHK7nErE+saoU/0eDUJHZVb
 6abEyZ4jzp/IPSXzurBWclhGiScjhBNutD+jd710rQKk1K+79RrDw5hnc+LoCRMC8up2r
 +HN9O+XGQX/GUtgz9p3QklSs0Oda3sdd8/IyHE8nWZlbZWR0EGBuPd+MMyFyoPqtwuQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=mlttDrJW; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=mlttDrJW
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DEFD880C17
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:07:14 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3acc96a256dso338479a91.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 20:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793156834; x=1793761634;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YVcyt8U4IFRF6jJNK3AhRUZq2Xye53lpxZ160TnQfXI=;
 b=mlttDrJWikWToJlZjBeqkBRXupndV9tVJXAGuyfvtHofZTs+3pndepFCpboBDnZZXp
 cvF3gDUgky3v6ZV5CrSjf/KMoFTDb3qKz9njyWXwV+Pc5CP2HTjC3vTQ+51Hqhpbnx9H
 GuGNy886hSF7h17wEYm9jzYIH8zkq/pPewEBQsmAcNZq7FQL15PR1NL8K429aw7XmWYc
 1BnK08dg0nXdQRKYCvDMDr8t9gHkgTeWE8l2svY3cxDBcGMmee7k/nZrzUcYKs16OMpf
 4Ujzg1B842DVw3zmpveYML9xndGE6T0XxQXMIsXG7MKkN36AOuYxzwO9LUPSLiu/VR+W
 cGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793156834; x=1793761634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YVcyt8U4IFRF6jJNK3AhRUZq2Xye53lpxZ160TnQfXI=;
 b=etPSR6+J0kZ+nkOETmGG4wbxLMHANsOfZ9kBQL4qyizQEzAmCHa3EqH/yoUaNlDlH0
 HAb7I2WA78hpkovac5IXuyRUGtBOqlKupmr5tga4/+DNIK+wvTq497fEdnfO4c8xOeRh
 Hp0pZZ5MXh7smMhZtTHXNdNaaUtpoms5pYWcG/4eJa9zeEvp/z4qF9ONdpjQZ1Su6+VU
 uLX71xTFwZPxSvPCCYAaESGEcAOdE0ffS62huHNHc4dk82mv1R7R8HcYLOR1klj707+t
 Z8/wryc5DjCdDGhxrDHyW9VIKlbr+KfzE1hJ6rj1ddr6WlenouC3VM9Fin5ohYJLVnFI
 LA6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMepFivQaWujsf3+M5HL1kSUh+OEgQvz1hfYbx9Yf/WSxbjncpZekKEHpv1kxoKPpdCsh9cvQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIHw/8tLaSSRf/bD7NQJjL8oFag41beUuRbyi8v6LnhR58034dF
 qdmrHaYQ/rc/oce+z6Lb6r7E1N2xp9iUfYq7vY8JG/ehgl8JO8So8fQkKd63Tg4B
X-Gm-Gg: AYBFou2mCkdwSYpH5ja2Am8sPtJEBlnIB4rZ4CRaLX8QKm4JNG3SK+Gby+Fxcm0BvyX
 gD58vEgr7yhvffshXq/91ner/FC5WrC8vhy7qsIF9Yb1PAVex8TpsWQumhemsqiKLvD2f0qnOJx
 RWqIcN8/tb7NdUqHZBRaUuktc48baAf5AVl04y8d9TlgPp8gOWh/smyVsuENabTysDtIYtR8J/+
 ivLGZPZhPziS20No9n8/AC7mxt/Ujxl8QydsI/mDZLjugruS//dm8866Gz/yOiEILgywpAOc29H
 9G5vcpj9MNWVLpoQ/wZwPXsyC/hBkaLBOpPpnfVi7iphvnCi9ojeEb3HTLbINoHl3u9yRyIa1fh
 5ssZVX9lNT2Z6JWKfxkVN7nPIjb65CGQknjS4RDwHHdUz2yndWiGh88GUtqQn/YsioCTZesv3qW
 5gorzZW96gtNkl910bVj87WBjpfOX6rK05mrcxgofuGHeOLjV7r19Z7FBBiLU3hQQ2ot7XDM9uW
 FmHnn+IAIOukSQEg5gh65OKDPk5JLxP1Ba9kQNL9zGBZx1lG6LFe4STTyn1uuWmUHY7mvBLHISS
 MabxfSyo5n234z7VB+bJwsaHNb4h2WGnVmO0BRSor7lDGZUJC28s3iBf2BXfCa0yUkCAuSNU6UJ
 qoTYXegPmG6YQCVfIVM40AV7+NbnpTAXpw7WhYbX8zgY08PtZgSBVB0lTKoRG7/vwfk441/ES71
 NVrqjH/u32+A==
X-Received: by 2002:a17:90b:440d:b0:3ab:e588:c288 with SMTP id
 98e67ed59e1d1-3ae57f9b14bmr720216a91.11.1793156834057; 
 Tue, 27 Oct 2026 20:07:14 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a5834b1sm798705a91.13.2026.10.27.20.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 20:07:13 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Alexey Charkov <alchark@flipper.net>,
 Guodong Xu <docular.xu@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/2] usb: onboard-hub: Add support for VIA Labs VL817
Date: Wed, 28 Oct 2026 11:07:08 +0800
Message-ID: <20261028030708.1608942-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ac90ab9b-35b8-45ec-a932-3f74ac26d78e@mailbox.org>
References: <20261026092432.769146-1-alan.tseng.cs@gmail.com>
 <20261026092432.769146-2-alan.tseng.cs@gmail.com>
 <ac90ab9b-35b8-45ec-a932-3f74ac26d78e@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On 10/26/26 14:19, Marek Vasut wrote:
>>   static const struct udevice_id usb_onboard_hub_ids[] = {
>>   	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
>> -	{	.compatible = "usb3431,6241",	/* Corechips SL6341 USB 2.0 */
>> +	{	.compatible = "usb2109,2817",	/* VIA Labs VL817 USB 2.0 */
>> +		.data = (ulong)&vialab_vl817_data,
>> +	}, {
>> +		.compatible = "usb2109,817",	/* VIA Labs VL817 USB 3.0 */
>
> Please keep the list sorted.

I put the new entries first to keep the list in string order: the
existing entries go usb3431, usb424, usb4b4, and "usb2109" sorts before
all of them.

Did you mean sorting by vendor ID as a number instead (0x424, 0x4b4,
0x2109, 0x3431)? That moves the existing entries too, so I would do it
in a separate patch before this one in v2.

Thanks,
Hung-Chun
