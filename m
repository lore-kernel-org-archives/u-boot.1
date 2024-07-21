Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF1CC3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F95986BF1;
	Sun, 21 Jul 2024 12:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="XAWZGaV6";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="sYghZCcZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 628E486DBD; Sun, 21 Jul 2024 12:41:22 +0200 (CEST)
Received: from fhigh5-smtp.messagingengine.com
 (fhigh5-smtp.messagingengine.com [103.168.172.156])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 915A98657F
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 488121140307;
 Sun, 21 Jul 2024 06:41:18 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
 by compute1.internal (MEProxy); Sun, 21 Jul 2024 06:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1721558478;
 x=1721644878; bh=O/Q8CDEv0vxvahhjdAif6uu6zjVGeryRD4eabobRaZs=; b=
 XAWZGaV6ZxWovcBe4n6jNdu0R3h6wt8Lf6wgKmdArpXFGUwJlUo8gb0kIgawJJ+7
 5b8AzlOOvpAQkrP03iNSL6tEINW90K8CH+hB83XklZgexwuKKt6bXRZym8TF2CGf
 0HeQ8z+C76KI1ZsDqv8gVr0hwiZOmgmI3DxaXqmcKJ+3FhABPvt1+RlvVlxjpBqX
 aYThIAu4mD/VsGKzVWKBoijczMGb+Dj5kLnyfE+lnlwI/rOno6YdWAjtRR4hB9zL
 6a587dcAiSIkt/xv81+Hc88LUeYozt7qzBXSh2vowxrKrAoaArE403CN5SZGsORq
 F07vPlY9YEt0bP11ylQoiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1721558478; x=
 1721644878; bh=O/Q8CDEv0vxvahhjdAif6uu6zjVGeryRD4eabobRaZs=; b=s
 YghZCcZRnX7KhP291hXBEU4EQXVhDjbYo4AKypABk3ajnWWSQXVs879dv+RExequ
 MUZgtX6hCsthY6pqvTclQbrWRdtDd5f/X4XpghQAz4jg76QZnmLX5RMFyMzMDWrr
 gO0UEbkUSajg1SqatjgBJ3WkdoE3KebJ0Fn0exiS8c5mV4wjg7l/b/qQ+KSEs9U1
 ybmrAd5AJmU7tIIuJ3FmVMY4l4RtSEhurg7N6HhFV6LH2kx8ZKXdcYs9EQIUX5dr
 gxyaaXuiUurGEzPkPf+Xo62nK6I6ivbOYgwJFqDK3OVvkfD18D46Wv5TQHxbIimc
 oW+LVYafurihP4o/HzGIg==
X-ME-Sender: <xms:zuWcZtjceZ7KSBngFGSJ8Q-vXqi4BPZFE_m9DpzdUgVjoWfFCzuamw>
 <xme:zuWcZiA0YyUvIp96KLXiFhkWIgI2mgERqCp_4zwGPjgCpPmiydxAiTo6KDECoEJt3
 w-AlKBnDXF9IIQ97p4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheehgdefvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
 rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
 eqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeu
 geevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:zuWcZtFJ8tC9NStMcmgzgCOfGTPjBLMpv0C9dfsElyNRIwMAyjOA2g>
 <xmx:zuWcZiSgCjUjmp7i5-GjmaF4y_TnWfW4yHU_qWgSZULraIoKW9jlzg>
 <xmx:zuWcZqxL2jbkcspTs9Sw8rxp9SzAYAsTnVSNkSTJj9UO2fBr8-67Aw>
 <xmx:zuWcZo5cZeYY8fVsUOrV4SZqeGGMryVmBOp6Lpx68ZMKueZqVZIcKg>
 <xmx:zuWcZhpYnapRkXacOJjBqlI-M-YYHycaV6ItFTQZmHi-l432AWQcYYPw>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 146CC19C0069; Sun, 21 Jul 2024 06:41:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
MIME-Version: 1.0
Message-Id: <f51bf747-053e-43db-97bf-dd60b0491f24@app.fastmail.com>
In-Reply-To: <CAFLszTgrM9Fz8mC=SQ69PRYsdZ5Y38VZYyCFeV3W6FL=DbJKkQ@mail.gmail.com>
References: <20240524-virtio_gpu-v2-0-b198c35b1fd2@flygoat.com>
 <20240524-virtio_gpu-v2-1-b198c35b1fd2@flygoat.com>
 <af3d7fbf-059e-45b1-bead-3118170d2eb7@app.fastmail.com>
 <CAFLszTjRuvRQGijGEVVRxcUXgHMMVzqqLUKwfinmY09fnwtd5w@mail.gmail.com>
 <93433b4e-2ea2-455d-bb23-f0d94b876a2e@app.fastmail.com>
 <CAFLszTgrM9Fz8mC=SQ69PRYsdZ5Y38VZYyCFeV3W6FL=DbJKkQ@mail.gmail.com>
Date: Sun, 21 Jul 2024 18:41:00 +0800
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Simon Glass" <sjg@chromium.org>
Cc: u-boot@lists.denx.de, "Tom Rini" <trini@konsulko.com>,
 "Bin Meng" <bmeng.cn@gmail.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 1/2] virtio: New virtio_gpu driver
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
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



=E5=9C=A82024=E5=B9=B47=E6=9C=8821=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=E5=
=8D=886:08=EF=BC=8CSimon Glass=E5=86=99=E9=81=93=EF=BC=9A
[...]
>> >> > +
>> >> > +     set_scanout_in =3D malloc(sizeof(struct virtio_gpu_set_sca=
nout));
>> >
>> > Could these structs be inside priv instead of allocating each one?
>>
>> Those structs are all used only once at initialization.
>>
>> We can save some runtime memory by freeing them here :-)
>
> Then you can just use a local var.

That will yield a huge stack frame that breaks booting on RISC-V virt bo=
ard :-(

Thanks
- Jiaxun

>
>>
>> >
>> >> > +     while (scanout_mask) {
>> >> > +             u32 active_scanout =3D ffs(scanout_mask) - 1;
>> >> > +
>> >> > +             set_scanout_in->r.x =3D 0;
>> >> > +             set_scanout_in->r.y =3D 0;
>> >> > +             set_scanout_in->r.width =3D cpu_to_virtio32(dev, u=
c_priv->xsize);
>> >> > +             set_scanout_in->r.height =3D cpu_to_virtio32(dev, =
uc_priv->ysize);
>> >> > +             set_scanout_in->scanout_id =3D cpu_to_virtio32(dev=
, active_scanout);
>> >> > +             set_scanout_in->resource_id =3D cpu_to_virtio32(de=
v,
>> >> > priv->scanout_res_id);
>> >> > +
>
> [..]
>
>> >> > +/* data passed in the cursor vq */
>> >> > +
>> >> > +struct virtio_gpu_cursor_pos {
>> >> > +     __le32 scanout_id;
>> >> > +     __le32 x;
>> >> > +     __le32 y;
>> >> > +     __le32 padding;
>> >> > +};
>> >> > +
>> >> > +/* VIRTIO_GPU_CMD_UPDATE_CURSOR, VIRTIO_GPU_CMD_MOVE_CURSOR */
>> >> > +struct virtio_gpu_update_cursor {
>> >> > +     struct virtio_gpu_ctrl_hdr hdr;
>> >> > +     struct virtio_gpu_cursor_pos pos;  /* update & move */
>> >> > +     __le32 resource_id;           /* update only */
>> >> > +     __le32 hot_x;                 /* update only */
>> >> > +     __le32 hot_y;                 /* update only */
>> >> > +     __le32 padding;
>> >> > +};
>> >> > +
>> >> > +/* data passed in the control vq, 2d related */
>> >
>> > But there are no comments so we don't know what these structs are f=
or
>> > or what the fields do. Can you add documentation, or a pointer to
>> > somewhere where it exists?
>>
>> The whole header is copied from Linux kernel so I=E2=80=99m not reall=
y sure if we want to edit it.
>>
>> Maybe I can mention about the specification at start of the driver co=
de?
>
> Yes that would help.
>
> I thought Linux's aversion to comments had softened a little?
>
> Regards,
> Simon

--=20
- Jiaxun
