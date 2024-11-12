Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC870D42B85
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:10:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4621D8918E;
	Tue, 12 Nov 2024 15:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Nls/qiZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D97808913B; Tue, 12 Nov 2024 15:10:54 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AF5789246
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731420651; x=1732025451; i=xypron.glpk@gmx.de;
 bh=Sxd+2A0BWR5OVzIlNI2uaLIOLcr5PUmYkkoWYCi//pU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Nls/qiZMWfMZBF7hFyWFhXOY42x9tK7EKga3Ik2sh2pRUndbdBFULBRJ8/GMptFi
 ayhm7zmqiX961/tVaSgcJPW6fw22mY1YywkXNPzuPADweG2JuCMGPjTPxWG97XKsw
 nc078SXj0PFophPj1hX5X5wHCco0DlUO4PIkXKfZ/PnV8nxFQQ5iiKx+aFPCcmUTg
 z+IqCz8U/x8VIzfR3ehfpxn3FP//tzyslaaE28uJAxbaJKKrsQVHD5BAEYQ0DO+hg
 ntXIVpOJVnMVk8y6UeYJQ9ul03a6R+rD4zUc3JSprKFzDqDugqdAAKtbHyyuxUWlU
 mBbrjnujhMLpE2FWOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MysRk-1twnWr1yWg-0138h3; Tue, 12
 Nov 2024 15:10:51 +0100
Message-ID: <c2fb549b-df19-438d-8b35-a0de604c253f@gmx.de>
Date: Tue, 12 Nov 2024 15:10:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: EFI File renaming
To: Traut Manuel LCPF-CH <Manuel.Traut@mt.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Venzin Daniel LCPF-CH <Daniel.Venzin@mt.com>,
 Gujan Armin LCPF-CH <Armin.Gujan@mt.com>, Manuel Traut <manut@mecka.net>,
 Burak Gerz <burak@gerz.io>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <PA4PR03MB67848E8118A8AF7AC8AF3C1BFA592@PA4PR03MB6784.eurprd03.prod.outlook.com>
 <CAC_iWj+2rBgsfNCjmW_Z8s9Zwu2NjzQFLUNAzehOgBszSYmCrQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWj+2rBgsfNCjmW_Z8s9Zwu2NjzQFLUNAzehOgBszSYmCrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7q978kWs3SoOkAeQ1aSrUu9g7IFVPb89tA9/DKNcdaoNh1UQreD
 fafJeGpoX14nQYbXo6LgbmjWkVO8JPeWI6seojvZyjwjYjnnKMrjDl2PJFPeaR+dA690L3B
 RpDQP2LVRgdJcwCJwlyQOclrBB1wkqQ6IIkzOToUDSN4UhWATa7lEXX3zd7nwP5BDlFGS3y
 sXrk/wkO8HhTiVrJz2eCQ==
UI-OutboundReport: notjunk:1;M01:P0:ABZJ9j7tTN8=;o6v9btfDzESwCpjo3Qvwl7lNJ+S
 MkIZHSNNPMlLRlbwgj4gQcLwEDfdiZK4PIzPmVJlNBPKr9lCx8XqFZb7IKMbgxQfs6AMfyRlP
 bR2vdGRFi4MnXq2Lislb7XYmIzzFTjS7/jCFCBItX770HpVKOmG8vL2e7ENhePd/BHkA2Skd9
 HcrbymutR9lHmczir3tQVymwTaYUpN6sql770PTx2MjKkLGCmtMXqhtgU2RWvwPLxBljyCiPF
 gjuFlHAECgWoQ3fouWeFBwIuAH8+8WJ+Pe6skNZDj8H895bFHJRwy3GzocSzIcUxGzj+6FWv8
 tCsoJwwgOQqu4TrAEZkDzydp6T/NpBXVvCmfUjqxAbYIMlSSGOc9QPiPlGvxVrWMwoRkXF+XK
 eIdko+DzPFBEzPjVBiTbCVKTF0snEfS2RzLbGsbB4tSGARzEQus1hrs02y/9vn+DSR99pN9Fb
 Fx8Zb50roCIyI9Esa0NZW2BHAJ6O4KRT3k69rJ2WCh7Du8rp985WawU8c6L3wLe1t3eD9Ne/q
 UXSWLSAyOke1+4dClAOngrG5gQuC4Cy9+ojkMLqEyyyZelwgYjICt8DfpwVom/ydMTzRqyX1L
 GdIDOJUeuLqEJ33azfS9aPlubGqb14D9frR+yqMXy1ohp1QjaWZ4JziDPCOXDaTr3xpo8e+m7
 LWoiiSRxk4marml1CxflDHKSMdscYUs7yw+Wvo9ocfE3F4LMzzgtmWoTzh+XnQlVe2iceF1CY
 V3HnISUag8vsKuE2vHD9BVD83bdZX498sFFsacMhzwOV2/8sKi+3v/uXgq1y0N9DyBvu6ViKM
 URigzYundxu/4qG2V6wIo01p2YI7N3GwLAl5YEmU9RHJ8BMwiZItkShczA1Jn2aASk+zL3AW6
 AGS8wC8edTA7eGkU6CyNjqAMmK0ClV0LRwq1u3I4kLu3cyyOc1mErvfgb
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

On 12.11.24 14:46, Ilias Apalodimas wrote:
> Hello Manuel,
>
> On Tue, 12 Nov 2024 at 15:21, Traut Manuel LCPF-CH <Manuel.Traut@mt.com>=
 wrote:
>>
>> Hi,
>>
>> systemd-boot counting logic requires [0] to be implemented.
>>
>> Is anybody already working on this?
>
> I am not aware of any patches
>
>>
>> If not we plan to add the functionality in fs/fs.c and fs/fat - correct=
?
>
> We don't have plans for it, but explaining any use cases you have might =
help
>
> Cheers
> /Ilias
>>
>> Cheers
>> Manuel
>>
>> [0] https://elixir.bootlin.com/u-boot/v2025.01-rc1/source/lib/efi_loade=
r/efi_file.c#L971

Hello Manuel,

The file system layer in fs/fat/fat_write.c does not support renaming, yet=
.

You would have to start your contributions there.

Best regards

Heinrich
