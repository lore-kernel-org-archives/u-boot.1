Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32201061B1C
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 19:05:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E6B283DBF;
	Mon, 30 Mar 2026 21:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="iAueds8D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10D8D83E7A; Mon, 30 Mar 2026 21:05:20 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E3078352B
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 21:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1774897503; x=1775502303; i=xypron.glpk@gmx.de;
 bh=+mYPiPBuJEJwbrW3ORUW6ZwY7iAS2iMozaBHefOx3TA=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=iAueds8DcSPER46o7vmGrxExHgpEDGsGNKowN1fQA/fAtYk/bvXZ7kwcdxMEIcJh
 Qjnn1jN1I5Y4wjlEsMHP0baOmyfFFkDnwJmg8uuEs6OcbDFT4Z3rMygu3HMYtzwFT
 kmXCnb/4gUznub8NjZd88YZhn9/IRE5m3IPIBj47TDrY7J2WbtFWImvjfiIT8RjVf
 kjlaDN75au7UC00K79NIs2bOvnvCpUa1XKqkXJwK0Yz5Ly+jgvaczGFGs2H6cG9Hg
 zokiIvVyq1J9Nuix1S7owtCa2m79hMvtXpE43H0iuKwtr331IdQqrsZWO0pNMya92
 R0SdUDe3uuzQeqO0dA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4z6k-1vQDvO2hgS-017J7Z; Mon, 30
 Mar 2026 21:05:02 +0200
Date: Mon, 30 Mar 2026 21:04:57 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, sjg@chromium.org,
 seanga2@gmail.com, sughosh.ganu@arm.com, ilias.apalodimas@linaro.org,
 gchan9527@gmail.com, mkorpershoek@kernel.org, hs@nabladev.com,
 marek.vasut+renesas@mailbox.org, msp@baylibre.com, dinesh.maniyam@altera.com, 
 peng.fan@nxp.com, quentin.schulz@cherry.de, kever.yang@rock-chips.com,
 jamie.gibbons@microchip.com, justin@tidylabs.net, n-francis@ti.com,
 h-vm@ti.com, ycliang@andestech.com, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_7/7=5D_misc=3A_update_API_docu?=
 =?US-ASCII?Q?mentation_for_bit_field_support_in_NVMEM?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260330171419.1117817-8-aswin.murugan@oss.qualcomm.com>
References: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
 <20260330171419.1117817-8-aswin.murugan@oss.qualcomm.com>
Message-ID: <62BA7B31-2700-41C6-94DE-39D9EB1161C6@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FrY8137WfqG1V3G9W+vgrMnxjuxX5rn0pseK3bp47tXnrtNEK4m
 RSbvuWjey6UTwJGI6+bCUhO7iC5z/Zgx/wOvrzoWS0sIJVrC2Dp6KQuLwR6CqT4IBX7zk3k
 voZwANfvgE4RbsoW67PTSBgq+vP+OKMsEWQK57z81v/frkmW/+hCqFO1Z5i5PHFjC73Wf8H
 KXZqxJQukSxsVqUlc4fZA==
UI-OutboundReport: notjunk:1;M01:P0:kUnVqrNMhGE=;wCN+OOKE3nh7ZGanKkz8bq2wDBt
 BBbJEfylj603a56p62o0FRsv8dhoSxgg85WddXdfH7WZG6jxRTj3WYsWqdTLP83SEnVN8Wm08
 b5RrwAxuftG1cRLj9I96/stLlbbDf47dgKcsmu6hDfZnwcJ9RViT/KY97WIPEyOIYuIEdBMVU
 WuCykPyZnmHpEhI42NIwe22/lRolIAMmIfZpWly/6tSXfaluQdICm/W7KZU6+0DYvc5vEtKKS
 vSnzjcV2VV3k3Psyd9iV4g251ODRR7oZqfqutIpCHtlfqwEuNf2g7uqHl6aoyipoA8lDWck23
 Iq+23ewV4QkHT4juN6O6acFo9OiULb9uv49ov4UwfK5BAI9vpvHNL/r0oUpJrVSt8dqVduHH4
 400G5R4Slr+YqNoG0LVb6j0KitfVRhBIzq2qKSVjP5lk8nRx8N2eAvZHVrzyucbcAzyWhTZhl
 l+yHT/Gz/ju35m/2yoib5nGBWSky4UrLxwBFSBJfKyp9UIkgxs8PXicLeC7RTz/D0OhYtGBtz
 WUW82ZWJQwRqShmrZ6bN9m97QUsGcd8QI9kW9MXbPi0sSV98PyWv923C17argeLUQjYC767Px
 j4k5C+BUMmUWnPPBODuBhVTP6zwXRlZNgvfllyO2ye7UBw3KNsqe5NhuuQP25D32b5p9vxxit
 SR5rVgEuB3nHtTXw5i293Z4N9IzcZ/PADe0ZFDdejmO1UYGAH2XvGAwy5XH1k46Zb8pjTzxBy
 uiy+yQTT6mAijZkVqxUZfH7MjFecHw0BMaMPCca/LZD7XWXQNGBraRa+JsZWKWzue337oHdif
 689tKUDL7gYhJ5e73jPdnw91/1BhOkmtDxv6qwdSDTrt1SNpOTELore17WA856YW9A+3umOfk
 QFxvkrauoiMtL4Khmdv6BzdiLDcKqwiJSNGGB/qVRhma4FrJvCrxTWwe+44VCUsG+Hp60hieM
 pNpwK5KTT6Qg4awjO2MmU7w3KRJyzMndOnT3ZNpv3PAntvqfC2VlepJ07nbsfZOQHN8cDwtqb
 48bKDKsaifF6S3iL58+7DL8mGsknpN2J8ZqL20+o6aBetI83+ljxiWGCqApuzKrEHsi2Q0qee
 lNm2Rs9b6WUI/r4Ce29uwFfbQo9mPTHTCGDWsa0UgWfGvDoTFILjS19BioAePAABoemSLlwkh
 R78XC7I4eyV58vn0VeTx6i/Jsv22rt0S55WWHkUz50gkWCdkhsAzHt8bE5Ke3lkn0H0iZAwax
 UIDCZ90cE8ETxMuY0zb3hvezzhpVWGo44VkOht56B9/40srHOi4f5mTUx+EpVaolrHCNHwY9H
 sh1BIA/0HnJCujzRVLk9Z6vFTtAbBrF4ll1lmagnij/Kwe8Endr6zv8DccEf/Lszg95U10Ccz
 inkNqeQaZsEijbaNmCFXBJF0rUOoo+vXyOjTPgOV2RTwY9r5tlAT8AO4t9B2KgpPtyP3toz1q
 jjD6ffbW2WPxVP9zTEZIpGUsUgxzxACSqv9j3cnW/JTM/xUUUQ+w/v55V4RnCTQnpTtOHwAJR
 Xr+2wlFm3zeqiQvAQWNlRlgehTsmLcAwe45J9BEBxGqfJWqX5V8G2MAWLfEdiF+mfr5QmZS5a
 wj+odDSLM/ZyJi8rDIosTdVnUUYXD8Wovdciqh7PzUIWRcyzuPxOgkiLfZdlmbN0wRnb33pqo
 Rj6m6ixTzBKy7WHZjy9DfFKZAbwnfjFyHgwPHFWV6Ur0mVKTRG+W3Ue8DbiGMOXewGHGLG6sR
 xbZorGFXVZqSbgnfUHL1qRNBxBAkbU5agqRHnB0ThAfTf6+YJqnLMOUIQHpV7OqsvvgFvPabO
 SSZw+MKf74jjgJz5nsdOOSXtggKOCyEjMdR78GCeLQrtO1aB44dJ9PVfi38GK9HrHVDbWjTuL
 sDWQT9gX7zIAfCHb4XZ9czkG2AwVF9rE2hdhVOfznVI4hMs8B7wqFHwqXoEVT2eofR+2FGLfK
 EECxXUbonaWErSA3KjmWx7Emyrq07uzvFWeTepR8Mkh3o10NtL81dkCpvpYirTSue1dN4g4Ni
 1SUTAK0rZAc1r+BGWsv2jWk/G4G1zO69rfuzhiwgsV07ToWL28RaDDxWPVBvHbGEcNJpSj2mw
 ic+sMO+1D9M7dkABtSS5eBBS4872r5o9KSLiPpMgXyCh1sRoW6bqNsk5R0+RpE1A5+R6m2qLz
 3r8ojoEsBDDMnmEv8IfTs2DtZ9qu7ohVtIdvZ+IjFSVPoUdzWbXmeOhQ9Nr8+2SBy7Z2i5l9U
 HlYsGwNWUYNbrXG1MqHaZylIezPPkpQp/iYzW6PXek2aWwP4NDNwukjT4dh0DbLhWr7GNYLg9
 m/Z+fjjDMkui3iv2pt6HCP9vn4fCF9EpcBej9Kr13f3lPHosFstSudMSU5yFDH059b5jJciIM
 RmRzVG/7vFTLRL4mWfaNZwkrQzI2aVkBxPOkLhPHeJ6UDpRGe02EmnA1X/UJ2WAwdaxqow3TA
 DgQrKTgxE4i1okYNt8Y23EV+w/g9e8+3iezMwe3+hDCDO+HoNHI+qOtiuR642OF8rI2cq7lhH
 9Ahf6uRZVG0IDhQIX5Ek0u1xMgXckCWSWagG5aXEx8wAsGE+yL0oi/hpZzWpAAzzta65bDnBb
 0a+tAqYdxXfQImFzrqp/HnzUSaYOx+2Ii6RAPRvEraWCRIHHpUZmE2ZN1kH37ERg6GAOBwnOg
 9GFus0ZwSckMy+xq3eMw/zY54JYa/hJSop282udx2XUoMpw2afJzeNygerg0Ed3DM0YXaE7+U
 qo/GZR6/9bjO8lAm57rplhlh/RGnfGuCjr7X6ubpHSHPGuSJwRduxCY74OGr4WQAm28k5bTbJ
 rf0//+x9HK6wwApjhzMPcN655VPxn6ySwLYFi1EN6fFkOAJnvYVUBWtf+aP340dERjnLGQPiP
 x0AP2dAyUO+rYy5r6ZUu1G8paHpxq3whv1NC71QPg4Dfm3Ov4onVKr20haGKEnNj9TzBEhu25
 wlv/2aPbdSUEe83Ye/g9IWZe21EMPTVB6bA+jSlAZhS9HfqgSEPB06HqwCzuh8uIOXA8xeAMj
 si2wdJ7lknOwz3yQ9BjxVFJBXVozDrorcGoe5sDzCzIcewtDXYBRCssUNN9EdTPW2PTSOvq3a
 pblZFnRw8ITBdRY5slpO9+svSC1VJ2Vmd5QMod/XffTirIFRbOuxKfXHqjE5zbjC7/xhUT+YT
 x8tRZ1+wxJdt/B7QLyZYU/mPLAfdJQPDPy1jDv+/ZJXIYnmPVT9vtQK65Q623c6ATcG7l5adA
 hURXb1w6NLWmyhWHhn2OFM7HPmxbJLzVgM17il2pZckDYZACU5PAOGDJACEq/Mg07V5rP37mO
 5sawVPqh8hDoh/nUTg4gI7T4D/PBxE+yxWkf+eWtjpLpPtU0i++5T/m01MEdvvMti70oqZzi9
 YzAo2/O51Ipn+83gx/AlfXVfFxi12bh8Slr3SyDHNlKYFPNonTEEvy7SjTKbh6ZQQXZAWzzAY
 CIF5a/Xs3vvfV8mX9MeRTkflQn1JSO+rtaJ97Mxvj9uOsePYUzuNbnHQ1b2LfBgnRN3jAobKH
 4tTYpltpsehhsPuY0WCD1Ekwrq5iFYOyCf6G75eKZAi2ryNV2PBwTrvpPR7FUi+bgwzw2SqBy
 0hMWrdOhqHGO+jfasNTxXpNVc14XIFYi7sUooNWIm7kg0vVho8KgA8x2IhPrOgP1OFkHZJEAA
 fVd7mBLVY07zkYCCxQoJAQG3cnW4b+9rEA+vnOL0d9ZnJwD+iM3+E7epHGkEpQL2uqcwQqUN3
 x3mJp0MEpcbq8VLN9fO19xL0KtcvmTRGbAnnXMlcazEcFMQvF3QqCF5RsD2HeZ7YLpq9boYVa
 HEMHkWvsQ0y3XBsibYSXb5MR8KENc+hMj+8dsKPlNuG70vJ4G3vT2UFSFVMDQxPCc4M8cih9X
 g88PiIj3P5PMevVo+mgoO1vV1WQiNXLFT5ck3WCN8Rdfe67y7SuoAqmxiqM7hGPj33cU2OFRL
 +hET9Ec/xS0PpsdLe1+0FobrJVsDWY8mYjewn78yX+u/dVS8VdkZAUE/dTBRb4upZSwBO/cNC
 543DDn/dha+B5rf5UuOaG5uVzlXf8V+o+Zb52YY655pHzUtgIDvAnBJE4nw9G54D1vIyBcbLD
 3GpaM9QfMMCkiw3jSsUYDli4gbvv/tNInxhtecXavWR8+no3NjBIevjv9Bd0kvNib+zBFHp/I
 qBIviL92guEYDh3SzDkG7Rw+1KV0hWHKKAXfGjY9Dlf31Y1XtnPY/rxE+cH7YICPsB9ICEqcW
 a++m7EN6qeGwfPLU7keZgHimej8nog7esph+urPX+BZzfYnG9B79lJRuxeiw1Z/z7OfSH9zFN
 DwZHJxzNS+BvARD/Ozu5e8Vqh/korW651qjDhS/HUpHHfICA/vmJoY8yA6Dn7MMe0/zgqef33
 JLHP3VdGr1QhAdtA2WjZ5bhQ9bIIXDEdYKgdiJ15PIx1r8K2R0QLIUcHr+S8AvQA1myz03qAE
 5RZWI5YFTkNQ78Vj/vbd3Ca9TWmA/j+BI4VOuzc8f9AV33VYE1qiCCDshGyZ/rEWUk4SJSpbY
 giTb+WodBxfSuZRMlbStakSzqfSoiXuptNSENm5PgJpFIvRBfHIGQ40JUfJ1cuCwfdDQ3o8zw
 IS5ywuJZLTO0f06Z+ach5FlJlMx12SJnyD+/Z66PEOgW64ocZogHjJkQXxCkFWFiHiluXa+Lz
 dVWjj6zNvwaQewx2XdwBRhkGYDw4n19mxvcUZnQGXO8kPwHKFzC1AVOq+zddFnFWE7a4RiFC1
 DVufAhnhXndZSxc4t0NjhyZ9P0rw3BAw2a0AVwAFd5gJicTDfnCm+qkyUz/3XPH9o+G2/SD0x
 YIXGT1ZFYG6qzkZ9ApCDE8Q165ok+AZbh9JRbhShJ0Q09ZxkWSxhyECdc5hL+h2RUj81p6lx+
 NYLfK/ZnWGDOPiT3khQGpDGSrV8Yg55OBh77lQao/SnWr1b1BvPjczmfzMnDOb8M81qSxHKo9
 TOJGIT1NAU5uvOQQUptG8UqICbfAE56scc1rpK0pxgvqK8oGB550J90wG5eY7XMjOOzeND3JL
 d47I4xQiO1SeQ4F5EPUoMwtmZevRMcy7SHcYUqZ28VuwofOYfwT8bxOf/IhjjA019GnOarpvD
 VC/ga3Kur8VGi/MwnDjjmtSpOGJjB7ZTOZQUxyScd3PU38r0uoEU6p6urzODB498wXAZa0jbp
 Q5KyycZdKGiXZbLLkeM25ihO/jGAgWqgtwRjZ5va13EzFsVDo8XuvmKdSHTANZ9q+SdnC1Zyi
 GIIv5ckaqdUZT0eAHuicMcZC1Hh3ybqNcRa/edoaHzWqal9rmgkSL5PxDpjxxX42rXM4UA3bq
 Byiz0GEn/LhciPj1IL52kXu9/QaiN/8hrsDVwnmbmZy/zSxwnzcLBkLOjXXYDDgXNQ2lbr7Ed
 ka
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

Am 30=2E M=C3=A4rz 2026 19:14:19 MESZ schrieb Aswin Murugan <aswin=2Emuruga=
n@oss=2Equalcomm=2Ecom>:
>Update the nvmem_cell_read() and nvmem_cell_write() documentation to
>describe the new bit field operation mode=2E
>
>The documentation now clearly explains:
>
>For bit field mode (nbits > 0):

Thank you for updating this documentation=2E=20

Please refer to @cell->nbits in the function documentation and also mentio=
n @cell->offset=2E

Best regards

Heinrich

>- Read: extracts the bit field from raw hardware bytes
>- Write: performs read-modify-write to preserve other bits
>- Requirements: buffer size must be sizeof(u32), cell size <=3D 4 bytes
>
>For non-bit-field mode (nbits =3D=3D 0):
>- Read/Write: direct byte-level access
>- Requirements: buffer size must equal the cell size
>
>This helps developers understand when to use each mode and the
>associated buffer size requirements=2E
>
>Signed-off-by: Aswin Murugan <aswin=2Emurugan@oss=2Equalcomm=2Ecom>
>---
> include/nvmem=2Eh | 24 ++++++++++++++++++++++--
> 1 file changed, 22 insertions(+), 2 deletions(-)
>
>diff --git a/include/nvmem=2Eh b/include/nvmem=2Eh
>index dd82122f16f=2E=2Eaf1d2594bd6 100644
>--- a/include/nvmem=2Eh
>+++ b/include/nvmem=2Eh
>@@ -47,9 +47,19 @@ struct udevice;
>  * @buf: The buffer to read into
>  * @size: The size of @buf
>  *
>+ * For cells with bit fields (nbits > 0), this function:
>+ * - Reads the raw bytes from hardware
>+ * - Extracts the bit field using bit_offset and nbits
>+ * - Returns the extracted value in @buf
>+ * - Requires @size =3D=3D sizeof(u32) and @cell->size <=3D 4
>+ *
>+ * For cells without bit fields (nbits =3D=3D 0):
>+ * - Reads raw bytes directly
>+ * - Requires @size =3D=3D @cell->size
>+ *
>  * Return:
>  * * 0 on success
>- * * -EINVAL if @buf is not the same size as @cell=2E
>+ * * -EINVAL if @size doesn't match requirements
>  * * -ENOSYS if CONFIG_NVMEM is disabled
>  * * A negative error if there was a problem reading the underlying stor=
age
>  */
>@@ -61,9 +71,19 @@ int nvmem_cell_read(struct nvmem_cell *cell, void *buf=
, size_t size);
>  * @buf: The buffer to write from
>  * @size: The size of @buf
>  *
>+ * For cells with bit fields (nbits > 0), this function:
>+ * - Performs Read-Modify-Write to preserve other bits
>+ * - Masks and shifts the value to the correct bit position
>+ * - Merges with existing bits outside the field
>+ * - Requires @size =3D=3D sizeof(u32) and @cell->size <=3D 4
>+ *
>+ * For cells without bit fields (nbits =3D=3D 0):
>+ * - Writes raw bytes directly
>+ * - Requires @size =3D=3D @cell->size
>+ *
>  * Return:
>  * * 0 on success
>- * * -EINVAL if @buf is not the same size as @cell
>+ * * -EINVAL if @size doesn't match requirements
>  * * -ENOSYS if @cell is read-only, or if CONFIG_NVMEM is disabled
>  * * A negative error if there was a problem writing the underlying stor=
age
>  */

